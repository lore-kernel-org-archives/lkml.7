Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDEEC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 538FA20874
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfDJB1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:27:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:14706 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfDJB1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:27:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 18:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,331,1549958400"; 
   d="gz'50?scan'50,208,50";a="290193285"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Apr 2019 18:27:41 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hE21c-0006Zt-GX; Wed, 10 Apr 2019 09:27:40 +0800
Date:   Wed, 10 Apr 2019 09:26:49 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: [rcu:dev.2019.04.09a 55/55] htmldocs: include/linux/rcupdate.h:837:
 warning: Function parameter or member 'rhf' not described in 'kfree_rcu'
Message-ID: <201904100948.T5UUmnja%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.04.09a
head:   108210466eaf3f9e0e18e250c3af4f2525963a60
commit: 108210466eaf3f9e0e18e250c3af4f2525963a60 [55/55] rcu: Make kfree_rcu() ignore NULL pointers
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/generic-radix-tree.h:1: warning: no structured comments found
>> include/linux/rcupdate.h:837: warning: Function parameter or member 'rhf' not described in 'kfree_rcu'
   include/linux/rcupdate.h:837: warning: Excess function parameter 'rcu_head' description in 'kfree_rcu'
   kernel/rcu/tree_plugin.h:1: warning: no structured comments found
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

vim +837 include/linux/rcupdate.h

   795	
   796	/*
   797	 * Helper macro for kfree_rcu() to prevent argument-expansion eyestrain.
   798	 */
   799	#define __kfree_rcu(head, offset) \
   800		do { \
   801			BUILD_BUG_ON(!__is_kfree_rcu_offset(offset)); \
   802			kfree_call_rcu(head, (rcu_callback_t)(unsigned long)(offset)); \
   803		} while (0)
   804	
   805	/**
   806	 * kfree_rcu() - kfree an object after a grace period.
   807	 * @ptr:	pointer to kfree
   808	 * @rcu_head:	the name of the struct rcu_head within the type of @ptr.
   809	 *
   810	 * Many rcu callbacks functions just call kfree() on the base structure.
   811	 * These functions are trivial, but their size adds up, and furthermore
   812	 * when they are used in a kernel module, that module must invoke the
   813	 * high-latency rcu_barrier() function at module-unload time.
   814	 *
   815	 * The kfree_rcu() function handles this issue.  Rather than encoding a
   816	 * function address in the embedded rcu_head structure, kfree_rcu() instead
   817	 * encodes the offset of the rcu_head structure within the base structure.
   818	 * Because the functions are not allowed in the low-order 4096 bytes of
   819	 * kernel virtual memory, offsets up to 4095 bytes can be accommodated.
   820	 * If the offset is larger than 4095 bytes, a compile-time error will
   821	 * be generated in __kfree_rcu().  If this error is triggered, you can
   822	 * either fall back to use of call_rcu() or rearrange the structure to
   823	 * position the rcu_head structure into the first 4096 bytes.
   824	 *
   825	 * Note that the allowable offset might decrease in the future, for example,
   826	 * to allow something like kmem_cache_free_rcu().
   827	 *
   828	 * The BUILD_BUG_ON check must not involve any function calls, hence the
   829	 * checks are done in macros here.
   830	 */
   831	#define kfree_rcu(ptr, rhf)						\
   832	do {									\
   833		typeof (ptr) ___p = (ptr);					\
   834										\
   835		if (___p)							\
   836			__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
 > 837	} while (0)
   838	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--gBBFr7Ir9EOA20Yy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gBBFr7Ir9EOA20Yy--
