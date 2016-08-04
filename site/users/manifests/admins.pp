class users::admins {
  users::managed_user {'joe':}
  users::managed_user {'alice':
    group => 'devel',
  }
  users::managed_user {'chen':
    group => 'devel',
  }
  group {'devel':
    ensure  => present,
  }
}
