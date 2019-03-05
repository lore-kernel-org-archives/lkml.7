Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972E7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3818A20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfCENYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:24:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:37314 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbfCENYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:24:05 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 05:24:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="gz'50?scan'50,208,50";a="139273777"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Mar 2019 05:23:59 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h1A34-0006eo-I8; Tue, 05 Mar 2019 21:23:58 +0800
Date:   Tue, 5 Mar 2019 21:22:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     kbuild-all@01.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com, liuyu712@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei@hisilicon.com, xuyiping@hisilicon.com,
        xuyoujun4@huawei.com, yudongbin@hisilicon.com,
        zangleigang@hisilicon.com, Yu Chen <chenyu56@huawei.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v3 09/12] usb: dwc3: Registering a role switch in the DRD
 code.
Message-ID: <201903052115.7IziZ8Er%fengguang.wu@intel.com>
References: <20190302090505.65542-10-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20190302090505.65542-10-chenyu56@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on balbi-usb/next]
[also build test WARNING on v5.0 next-20190305]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yu-Chen/Add-support-for-usb-on-Hikey960/20190305-062824
base:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git next
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   WARNING: convert(1) not found, for SVG to PDF conversion install ImageMagick (https://www.imagemagick.org)
   include/linux/rcupdate_wait.h:1: warning: no structured comments found
   include/linux/rcutree.h:1: warning: no structured comments found
   kernel/rcu/tree.c:710: warning: Excess function parameter 'irq' description in 'rcu_nmi_exit'
   include/linux/gfp.h:1: warning: no structured comments found
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.ibss' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.connect' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.keys' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.ie' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.ie_len' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.bssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.ssid' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.default_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.default_mgmt_key' not described in 'wireless_dev'
   include/net/cfg80211.h:4687: warning: Function parameter or member 'wext.prev_bssid_valid' not described in 'wireless_dev'
   include/net/mac80211.h:2393: warning: Function parameter or member 'radiotap_timestamp.units_pos' not described in 'ieee80211_hw'
   include/net/mac80211.h:2393: warning: Function parameter or member 'radiotap_timestamp.accuracy' not described in 'ieee80211_hw'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.rts_cts_rate_idx' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.use_rts' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.use_cts_prot' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.short_preamble' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.skip_table' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.jiffies' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.vif' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.hw_key' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.flags' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'control.enqueue_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'ack' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'ack.cookie' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.ampdu_ack_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.ampdu_len' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.antenna' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.tx_time' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.is_valid_ack_signal' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'status.status_driver_data' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'driver_rates' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'pad' not described in 'ieee80211_tx_info'
   include/net/mac80211.h:1004: warning: Function parameter or member 'rate_driver_data' not described in 'ieee80211_tx_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'rx_stats_avg' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'rx_stats_avg.signal' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'rx_stats_avg.chain_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.filtered' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.retry_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.retry_count' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.lost_packets' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.last_tdls_pkt_time' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.msdu_retries' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.msdu_failed' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.last_ack' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.last_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.ack_signal_filled' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'status_stats.avg_ack_signal' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'tx_stats.packets' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'tx_stats.bytes' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'tx_stats.last_rate' not described in 'sta_info'
   net/mac80211/sta_info.h:590: warning: Function parameter or member 'tx_stats.msdu' not described in 'sta_info'
   kernel/rcu/tree.c:711: warning: Excess function parameter 'irq' description in 'rcu_nmi_exit'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_excl.active' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.cb' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.poll' not described in 'dma_buf'
   include/linux/dma-buf.h:304: warning: Function parameter or member 'cb_shared.active' not described in 'dma_buf'
   include/linux/dma-fence-array.h:54: warning: Function parameter or member 'work' not described in 'dma_fence_array'
   include/linux/firmware/intel/stratix10-svc-client.h:1: warning: no structured comments found
   include/linux/gpio/driver.h:371: warning: Function parameter or member 'init_valid_mask' not described in 'gpio_chip'
   include/linux/iio/hw-consumer.h:1: warning: no structured comments found
   include/linux/input/sparse-keymap.h:46: warning: Function parameter or member 'sw' not described in 'key_entry'
   drivers/mtd/nand/raw/nand_base.c:420: warning: Function parameter or member 'chip' not described in 'nand_fill_oob'
   drivers/mtd/nand/raw/nand_bbt.c:173: warning: Function parameter or member 'this' not described in 'read_bbt'
   drivers/mtd/nand/raw/nand_bbt.c:173: warning: Excess function parameter 'chip' description in 'read_bbt'
   include/linux/regulator/machine.h:199: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
   include/linux/regulator/driver.h:228: warning: Function parameter or member 'resume' not described in 'regulator_ops'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw0' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw1' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw2' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.esw3' not described in 'irb'
   arch/s390/include/asm/cio.h:245: warning: Function parameter or member 'esw.eadm' not described in 'irb'
   drivers/slimbus/stream.c:1: warning: no structured comments found
   include/linux/spi/spi.h:180: warning: Function parameter or member 'driver_override' not described in 'spi_device'
   drivers/target/target_core_device.c:1: warning: no structured comments found
>> drivers/usb/dwc3/core.h:1231: warning: Function parameter or member 'role_sw' not described in 'dwc3'
>> drivers/usb/dwc3/core.h:1231: warning: Function parameter or member 'role_switch_default_mode' not described in 'dwc3'
   drivers/usb/dwc3/core.h:1231: warning: Function parameter or member 'dis_split_quirk' not described in 'dwc3'
   drivers/usb/dwc3/core.h:1231: warning: Function parameter or member 'gctl_reset_quirk' not described in 'dwc3'
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
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:382: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:383: warning: cannot understand function prototype: 'struct amdgpu_vm_pt_cursor '
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'start' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'end' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:555: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_leaf'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:603: warning: Function parameter or member 'adev' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:603: warning: Function parameter or member 'vm' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:603: warning: Function parameter or member 'cursor' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:603: warning: Function parameter or member 'entry' not described in 'for_each_amdgpu_vm_pt_dfs_safe'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:845: warning: Function parameter or member 'level' not described in 'amdgpu_vm_bo_param'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1350: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_func'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'params' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'bo' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'level' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'pe' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'addr' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'count' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'incr' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1517: warning: Function parameter or member 'flags' not described in 'amdgpu_vm_update_huge'
   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3093: warning: Function parameter or member 'pasid' not described in 'amdgpu_vm_make_compute'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:128: warning: Incorrect use of kernel-doc format: Documentation Makefile include scripts source @atomic_obj
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'atomic_obj' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'atomic_obj_lock' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'backlight_link' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'backlight_caps' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'freesync_module' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'fw_dmcu' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:203: warning: Function parameter or member 'dmcu_fw_version' not described in 'amdgpu_display_manager'
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1: warning: no structured comments found
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_pin' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_unpin' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_res_obj' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_get_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_import_sg_table' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_vmap' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_vunmap' not described in 'drm_driver'
   include/drm/drm_drv.h:618: warning: Function parameter or member 'gem_prime_mmap' not described in 'drm_driver'
   include/drm/drm_atomic_state_helper.h:1: warning: no structured comments found
   drivers/gpu/drm/drm_dp_helper.c:1364: warning: Function parameter or member 'dsc_dpcd' not described in 'drm_dp_dsc_sink_max_slice_count'
   drivers/gpu/drm/drm_dp_helper.c:1364: warning: Function parameter or member 'is_edp' not described in 'drm_dp_dsc_sink_max_slice_count'
   drivers/gpu/drm/i915/i915_vma.h:49: warning: cannot understand function prototype: 'struct i915_vma '
   drivers/gpu/drm/i915/i915_vma.h:1: warning: no structured comments found
   drivers/gpu/drm/i915/intel_guc_fwif.h:536: warning: cannot understand function prototype: 'struct guc_log_buffer_state '
   drivers/gpu/drm/i915/i915_trace.h:1: warning: no structured comments found
   include/linux/skbuff.h:876: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'list' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
   include/linux/skbuff.h:876: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
   include/net/sock.h:238: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
   include/net/sock.h:238: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'

vim +1231 drivers/usb/dwc3/core.h

72246da4 Felipe Balbi 2011-08-19 @1231  

:::::: The code at line 1231 was first introduced by commit
:::::: 72246da40f3719af3bfd104a2365b32537c27d83 usb: Introduce DesignWare USB3 DRD Driver

:::::: TO: Felipe Balbi <balbi@ti.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--cNdxnHkX5QqsyA0e
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--cNdxnHkX5QqsyA0e--
