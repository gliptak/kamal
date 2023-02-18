class Mrsk::Cli::Prune < Mrsk::Cli::Base
  desc "all", "Prune unused images and stopped containers"
  def all
    invoke :containers
    invoke :images
  end

  desc "images", "Prune unused images older than 7 days"
  def images
    on(MRSK.hosts) do
      execute *MRSK.auditor.record("Pruned images"), verbosity: :debug
      execute *MRSK.prune.images
    end
  end

  desc "containers", "Prune stopped containers for the service older than 3 days"
  def containers
    on(MRSK.hosts) do
      execute *MRSK.auditor.record("Pruned containers"), verbosity: :debug
      execute *MRSK.prune.containers
    end
  end
end
