Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B5EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C152087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 06:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfECG7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 02:59:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:16267 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfECG7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 02:59:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 23:59:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,424,1549958400"; 
   d="gz'50?scan'50,208,50";a="145650884"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 May 2019 23:59:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hMSAV-000GxP-Du; Fri, 03 May 2019 14:59:39 +0800
Date:   Fri, 3 May 2019 14:58:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [rcu:dev.2019.04.28a 85/85] htmldocs: kernel/rcu/sync.c:74: warning:
 Function parameter or member 'rcu' not described in 'rcu_sync_func'
Message-ID: <201905031452.Nu9N5LwE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.04.28a
head:   a4e0e069df6e8718bf165fb009cd3a23e7a808a3
commit: a4e0e069df6e8718bf165fb009cd3a23e7a808a3 [85/85] rcu/sync: Simplify the state machine
reproduce: make htmldocs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/generic-radix-tree.h:1: warning: no structured comments found
   kernel/rcu/tree_plugin.h:1: warning: no structured comments found
>> kernel/rcu/sync.c:74: warning: Function parameter or member 'rcu' not described in 'rcu_sync_func'
   kernel/rcu/sync.c:74: warning: Excess function parameter 'rhp' description in 'rcu_sync_func'
   kernel/rcu/tree_plugin.h:1: warning: no structured comments found
   include/linux/firmware/intel/stratix10-svc-client.h:1: warning: no structured comments found
   include/linux/gpio/driver.h:371: warning: Function parameter or member 'init_valid_mask' not described in 'gpio_chip'
   include/linux/i2c.h:343: warning: Function parameter or member 'init_irq' not described in 'i2c_client'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/regulator/machine.h:199: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:228: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   drivers/slimbus/stream.c:1: warning: no structured comments found
   include/linux/spi/spi.h:188: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   drivers/target/target_core_device.c:1: warning: no structured comments found
   drivers/usb/typec/bus.c:1: warning: no structured comments found
   drivers/usb/typec/class.c:1: warning: no structured comments found
   include/linux/w1.h:281: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
   fs/direct-io.c:257: warning: Excess function parameter 'offset' description in 'dio_complete'
   fs/file_table.c:1: warning: no structured comments found
   fs/libfs.c:477: warning: Excess function parameter 'available' description in 'simple_write_end'
   fs/posix_acl.c:646: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:646: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:646: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:294: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:294: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:294: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:343: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:183: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Function parameter or member 'range' not described in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:295: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_start_hsa'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Function parameter or member 'range' not described in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'mm' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'start' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:344: warning: Excess function parameter 'end' description in 'amdgpu_mn_invalidate_range_end'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:374: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:375: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:547: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:547: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:547: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:547: warning: Function parameter or member 'end' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:547: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:595: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:595: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:595: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:595: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:866: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1346: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1514: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3105: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:375: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:376: warning: Function parameter or member 'ih' not described in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:376: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:128: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source @atomic_obj
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'atomic_obj' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'atomic_obj_lock' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'backlight_link' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'backlight_caps' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'freesync_module' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'fw_dmcu' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'dmcu_fw_version' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: no structured comments found
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:715: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_atomic_state_helper.h:1: warning: no structured comments found
   drivers/gpu/drm/scheduler/sched_main.c:376: warning: Excess function parameter 'bad' description in 'drm_sched_stop'
   drivers/gpu/drm/scheduler/sched_main.c:377: warning: Excess function parameter 'bad' description in 'drm_sched_stop'
   drivers/gpu/drm/scheduler/sched_main.c:420: warning: Function parameter or member 'full_recovery' not described in 'drm_sched_start'
   drivers/gpu/drm/i915/i915_vma.h:50: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   drivers/gpu/drm/i915/intel_guc_fwif.h:536: warning: cannot understand function prototype: 'struct guc_log_buffer_state '
   drivers/gpu/drm/i915/i915_trace.h:1: warning: no structured comments found
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:126: warning: Function parameter or member 'hw_id' not described in 'komeda_component'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:126: warning: Function parameter or member 'max_active_outputs' not described in 'komeda_component'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:126: warning: Function parameter or member 'supported_outputs' not described in 'komeda_component'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:142: warning: Function parameter or member 'output_port' not described in 'komeda_component_output'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'component' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'crtc' not described in 'komeda_component_state'
   drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h:196: warning: Function parameter or member 'plane' not described in 'komeda_component_state'

vim +74 kernel/rcu/sync.c

cc44ca84 Oleg Nesterov    2015-08-21   49  
cc44ca84 Oleg Nesterov    2015-08-21   50  /**
cc44ca84 Oleg Nesterov    2015-08-21   51   * rcu_sync_func() - Callback function managing reader access to fastpath
27fdb35f Paul E. McKenney 2017-10-19   52   * @rhp: Pointer to rcu_head in rcu_sync structure to use for synchronization
cc44ca84 Oleg Nesterov    2015-08-21   53   *
a4e0e069 Oleg Nesterov    2019-04-25   54   * This function is passed to call_rcu() function by rcu_sync_enter() and
cc44ca84 Oleg Nesterov    2015-08-21   55   * rcu_sync_exit(), so that it is invoked after a grace period following the
a4e0e069 Oleg Nesterov    2019-04-25   56   * that invocation of enter/exit.
a4e0e069 Oleg Nesterov    2019-04-25   57   *
a4e0e069 Oleg Nesterov    2019-04-25   58   * If it is called by rcu_sync_enter() it signals that all the readers were
a4e0e069 Oleg Nesterov    2019-04-25   59   * switched onto slow path.
a4e0e069 Oleg Nesterov    2019-04-25   60   *
a4e0e069 Oleg Nesterov    2019-04-25   61   * If it is called by rcu_sync_exit() it takes action based on events that
cc44ca84 Oleg Nesterov    2015-08-21   62   * have taken place in the meantime, so that closely spaced rcu_sync_enter()
cc44ca84 Oleg Nesterov    2015-08-21   63   * and rcu_sync_exit() pairs need not wait for a grace period.
cc44ca84 Oleg Nesterov    2015-08-21   64   *
cc44ca84 Oleg Nesterov    2015-08-21   65   * If another rcu_sync_enter() is invoked before the grace period
cc44ca84 Oleg Nesterov    2015-08-21   66   * ended, reset state to allow the next rcu_sync_exit() to let the
cc44ca84 Oleg Nesterov    2015-08-21   67   * readers back onto their fastpaths (after a grace period).  If both
cc44ca84 Oleg Nesterov    2015-08-21   68   * another rcu_sync_enter() and its matching rcu_sync_exit() are invoked
cc44ca84 Oleg Nesterov    2015-08-21   69   * before the grace period ended, re-invoke call_rcu() on behalf of that
cc44ca84 Oleg Nesterov    2015-08-21   70   * rcu_sync_exit().  Otherwise, set all state back to idle so that readers
cc44ca84 Oleg Nesterov    2015-08-21   71   * can again use their fastpaths.
cc44ca84 Oleg Nesterov    2015-08-21   72   */
a4e0e069 Oleg Nesterov    2019-04-25   73  static void rcu_sync_func(struct rcu_head *rcu)
cc44ca84 Oleg Nesterov    2015-08-21  @74  {
a4e0e069 Oleg Nesterov    2019-04-25   75  	struct rcu_sync *rsp = container_of(rcu, struct rcu_sync, cb_head);
cc44ca84 Oleg Nesterov    2015-08-21   76  	unsigned long flags;
cc44ca84 Oleg Nesterov    2015-08-21   77  
a4e0e069 Oleg Nesterov    2019-04-25   78  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
a4e0e069 Oleg Nesterov    2019-04-25   79  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
cc44ca84 Oleg Nesterov    2015-08-21   80  
cc44ca84 Oleg Nesterov    2015-08-21   81  	spin_lock_irqsave(&rsp->rss_lock, flags);
cc44ca84 Oleg Nesterov    2015-08-21   82  	if (rsp->gp_count) {
cc44ca84 Oleg Nesterov    2015-08-21   83  		/*
a4e0e069 Oleg Nesterov    2019-04-25   84  		 * We're at least a GP after the GP_IDLE->GP_ENTER transition.
cc44ca84 Oleg Nesterov    2015-08-21   85  		 */
a4e0e069 Oleg Nesterov    2019-04-25   86  		WRITE_ONCE(rsp->gp_state, GP_PASSED);
a4e0e069 Oleg Nesterov    2019-04-25   87  		wake_up_locked(&rsp->gp_wait);
a4e0e069 Oleg Nesterov    2019-04-25   88  	} else if (rsp->gp_state == GP_REPLAY) {
cc44ca84 Oleg Nesterov    2015-08-21   89  		/*
a4e0e069 Oleg Nesterov    2019-04-25   90  		 * A new rcu_sync_exit() has happened; requeue the callback to
a4e0e069 Oleg Nesterov    2019-04-25   91  		 * catch a later GP.
cc44ca84 Oleg Nesterov    2015-08-21   92  		 */
a4e0e069 Oleg Nesterov    2019-04-25   93  		WRITE_ONCE(rsp->gp_state, GP_EXIT);
a4e0e069 Oleg Nesterov    2019-04-25   94  		rcu_sync_call(rsp);
cc44ca84 Oleg Nesterov    2015-08-21   95  	} else {
cc44ca84 Oleg Nesterov    2015-08-21   96  		/*
a4e0e069 Oleg Nesterov    2019-04-25   97  		 * We're at least a GP after the last rcu_sync_exit(); eveybody
a4e0e069 Oleg Nesterov    2019-04-25   98  		 * will now have observed the write side critical section.
a4e0e069 Oleg Nesterov    2019-04-25   99  		 * Let 'em rip!.
cc44ca84 Oleg Nesterov    2015-08-21  100  		 */
a4e0e069 Oleg Nesterov    2019-04-25  101  		WRITE_ONCE(rsp->gp_state, GP_IDLE);
cc44ca84 Oleg Nesterov    2015-08-21  102  	}
cc44ca84 Oleg Nesterov    2015-08-21  103  	spin_unlock_irqrestore(&rsp->rss_lock, flags);
cc44ca84 Oleg Nesterov    2015-08-21  104  }
cc44ca84 Oleg Nesterov    2015-08-21  105  

:::::: The code at line 74 was first introduced by commit
:::::: cc44ca848f5e517aeca9f5eabbe13609a3f71450 rcu: Create rcu_sync infrastructure

:::::: TO: Oleg Nesterov <oleg@redhat.com>
:::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--J2SCkAp4GZ/dPZZf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
2aiBVEreZvwPD662H+JcAAA=

--J2SCkAp4GZ/dPZZf--
