Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448A9CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CCE20866
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 03:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfJ3DXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 23:23:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:16829 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbfJ3DXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 23:23:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 20:23:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="gz'50?scan'50,208,50";a="400007749"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 29 Oct 2019 20:23:27 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iPeZz-000J6u-EY; Wed, 30 Oct 2019 11:23:27 +0800
Date:   Wed, 30 Oct 2019 11:22:51 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     kbuild-all@lists.01.org, miquel.raynal@bootlin.com, richard@nod.at,
        marek.vasut@gmail.com, dwmw2@infradead.org, bbrezillon@kernel.org,
        computersforpeace@gmail.com, vigneshr@ti.com, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        masonccyang@mxic.com.tw
Subject: Re: [PATCH v2 1/4] mtd: rawnand: Add support manufacturer specific
 lock/unlock operatoin
Message-ID: <201910301141.SRkwXAwu%lkp@intel.com>
References: <1572256527-5074-2-git-send-email-masonccyang@mxic.com.tw>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y3hllse2drclbgb2"
Content-Disposition: inline
In-Reply-To: <1572256527-5074-2-git-send-email-masonccyang@mxic.com.tw>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y3hllse2drclbgb2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mason,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.4-rc5 next-20191029]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Mason-Yang/mtd-rawnand-Add-support-Macronix-Block-Protection-deep-power-down-mode/20191030-071757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 23fdb198ae81f47a574296dab5167c5e136a02ba
reproduce: make htmldocs

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   Warning: The Sphinx 'sphinx_rtd_theme' HTML theme was not found. Make sure you have the theme installed to produce pretty HTML output. Falling back to the default theme.
   WARNING: dot(1) not found, for better output quality install graphviz from http://www.graphviz.org
   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:223: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   include/linux/w1.h:277: warning: Function parameter or member 'of_match_table' not described in 'w1_family'
   include/linux/spi/spi.h:190: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
   include/linux/lsm_hooks.h:1822: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
   drivers/gpio/gpiolib-of.c:92: warning: Excess function parameter 'dev' description in 'of_gpio_need_valid_mask'
   include/linux/i2c.h:337: warning: Function parameter or member 'init_irq' not described in 'i2c_client'
   lib/genalloc.c:1: warning: 'gen_pool_add_virt' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc' not found
   lib/genalloc.c:1: warning: 'gen_pool_free' not found
   lib/genalloc.c:1: warning: 'gen_pool_alloc_algo' not found
>> include/linux/mtd/rawnand.h:1143: warning: Function parameter or member '_lock' not described in 'nand_chip'
>> include/linux/mtd/rawnand.h:1143: warning: Function parameter or member '_unlock' not described in 'nand_chip'
>> drivers/mtd/nand/raw/nand_base.c:4365: warning: Function parameter or member 'ofs' not described in 'nand_lock'
>> drivers/mtd/nand/raw/nand_base.c:4365: warning: Function parameter or member 'len' not described in 'nand_lock'
>> drivers/mtd/nand/raw/nand_base.c:4379: warning: Function parameter or member 'ofs' not described in 'nand_unlock'
>> drivers/mtd/nand/raw/nand_base.c:4379: warning: Function parameter or member 'len' not described in 'nand_unlock'
   fs/posix_acl.c:647: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
   fs/posix_acl.c:647: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
   drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
   drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file drivers/dma-buf/reservation.c
   Error: Cannot open file include/linux/reservation.h
   Error: Cannot open file include/linux/reservation.h
   kernel/dma/coherent.c:1: warning: no structured comments found
   include/linux/input/sparse-keymap.h:43: warning: Function parameter or member 'sw' not described in 'key_entry'
   include/linux/skbuff.h:888: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:888: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:233: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
   include/net/sock.h:233: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
   include/net/sock.h:515: warning: Function parameter or member 'sk_rx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_tx_skb_cache' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
   include/net/sock.h:515: warning: Function parameter or member 'sk_bpf_storage' not described in 'sock'
   include/net/sock.h:2450: warning: Function parameter or member 'tcp_rx_skb_cache_key' not described in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2450: warning: Excess function parameter 'sk' description in 'DECLARE_STATIC_KEY_FALSE'
   include/net/sock.h:2450: warning: Excess function parameter 'skb' description in 'DECLARE_STATIC_KEY_FALSE'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member '____cacheline_aligned_in_smp' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
   include/linux/netdevice.h:2053: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
   include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
   include/linux/rculist.h:374: warning: Excess function parameter 'cond' description in 'list_for_each_entry_rcu'
   include/linux/rculist.h:651: warning: Excess function parameter 'cond' description in 'hlist_for_each_entry_rcu'
   mm/util.c:1: warning: 'get_user_pages_fast' not found
   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:335: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c:336: warning: Excess function parameter 'dev' description in 'amdgpu_gem_prime_export'
   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:142: warning: Function parameter or member 'blockable' not described in 'amdgpu_mn_read_lock'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:347: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:348: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:494: warning: Function parameter or member 'start' not described in 'amdgpu_vm_pt_first_dfs'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:546: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:821: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1283: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_flags'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2821: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:378: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Function parameter or member 'ih' not described in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:379: warning: Excess function parameter 'entry' description in 'amdgpu_irq_dispatch'
   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1: warning: no structured comments found

vim +1143 include/linux/mtd/rawnand.h

^1da177e4c3f41 include/linux/mtd/nand.h Linus Torvalds 2005-04-16 @1143  

:::::: The code at line 1143 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--y3hllse2drclbgb2
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--y3hllse2drclbgb2--
