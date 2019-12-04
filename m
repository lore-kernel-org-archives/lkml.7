Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C75AC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AA82077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6xDWb/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfLDKKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:10:16 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:38675 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfLDKKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:10:15 -0500
Received: by mail-pj1-f42.google.com with SMTP id l4so2813537pjt.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 02:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qve5IQe/DMqu+WimQiVTPatAWSiV1JcjQhlG9ESw8Yc=;
        b=s6xDWb/ccPM8SROsDJtBaRMiRz1KP+o60u48Ix5upZPs6tiV1k39fnJQWh3YyOYP6Z
         ovkYunmH/PW45CFMW138NTeyIebxw6h97EKIRFLcO3FQ2gHsNliKQPdJK0jdG68cAecI
         NfEigBmXWWuZNKnpjaNnXkuzQ8WjBIFUcMPXvqBF5z+Vv3Y9YRFqgcTqmGIMKtDAqWt8
         Yx5KZDT5iGngdV2ja7Iyz6Kwjqxgx470KguXntuES9rVfATOYgvCEWWQVJZjnuJ8uxmC
         hoLPgPWg3Eb5eB5t1xn33Dt6Yy4gdAgWmvHXt5ieWFPnb5cJjEYymAATq0Kac+Vb9O0E
         9PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qve5IQe/DMqu+WimQiVTPatAWSiV1JcjQhlG9ESw8Yc=;
        b=XEXu+0UQtv4R46/3oprNIlrSAAxjoHDGqsMFePP9r/RJfEsvjz1LajdTMFvwrxTJGz
         N3Tuim7Jv4WvzzM0OGKbNCBqOYs6RrNdyAjHZupPyAkj1SFMitbChUzWPOxqDN2vwTXy
         3OYdvXMgEjfBkA75mpieSPfgQhPYUIwmvqbskID3lwiAatzrmzoEQTAxxlW8xdxNQq0k
         /79aHY3iF9bYDYeGGfZRXRibGnHOWF4EKPSjcSEAtP70eHtwWH8duq9vk2XaNCN4sFVh
         tcxV1ffWLAyjKvSDt2dZ9HV/JSe6K9HuBrF06xRbRVgVz6gFRFRwk8e0tC/bV8JpwEc3
         1/iw==
X-Gm-Message-State: APjAAAWO0Y/k1UkzOv8sEwshsEeoYphZOzZ5RE4pXqb21y1Gxt5c0o3n
        K/pE2x9Q2i+nV2rgqDo37yo=
X-Google-Smtp-Source: APXvYqzoJIPWVXvXqHVLwsvFawFB4T15bp8fC+0rRSBBzEgftenYef3Ei9hIUBremk8PLi4A9OXklQ==
X-Received: by 2002:a17:90a:65cb:: with SMTP id i11mr2375816pjs.23.1575454203951;
        Wed, 04 Dec 2019 02:10:03 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:cdb:94ce:3984:ab1:9b44:803])
        by smtp.gmail.com with ESMTPSA id r62sm7941724pfc.89.2019.12.04.02.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 02:10:02 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] Documentation: filesystems: automount-support: Change reference to document autofs.txt to autofs.rst
Date:   Wed,  4 Dec 2019 15:39:41 +0530
Message-Id: <20191204100941.6268-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch fixes the following documentation build warning:

Warning: Documentation/filesystems/automount-support.txt references
 a file that doesn't exist: Documentation/filesystems/autofs.txt

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 .../filesystems/automount-support.txt         |    2 +-
 doc.txt                                       |  492 ++
 four.txt                                      | 7656 +++++++++++++++++
 fs/nfs/dir.c                                  |    2 +-
 scripts/pnmtologo                             |  Bin 0 -> 18112 bytes
 5 files changed, 8150 insertions(+), 2 deletions(-)
 create mode 100644 doc.txt
 create mode 100644 four.txt
 create mode 100755 scripts/pnmtologo

diff --git a/Documentation/filesystems/automount-support.txt b/Documentation/filesystems/automount-support.txt
index b0afd3d55eaf..7d9f82607562 100644
--- a/Documentation/filesystems/automount-support.txt
+++ b/Documentation/filesystems/automount-support.txt
@@ -9,7 +9,7 @@ also be requested by userspace.
 IN-KERNEL AUTOMOUNTING
 ======================
 
-See section "Mount Traps" of  Documentation/filesystems/autofs.txt
+See section "Mount Traps" of  Documentation/filesystems/autofs.rst
 
 Then from userspace, you can just do something like:
 
diff --git a/doc.txt b/doc.txt
new file mode 100644
index 000000000000..ea9122ed0637
--- /dev/null
+++ b/doc.txt
@@ -0,0 +1,492 @@
+Documentation/sphinx/../%s.rst: :doc:`%s <../%s>`
+Warning: Documentation/devicetree/bindings/arm/arm,scmi.txt references a file that doesn't exist: Documentation/devicetree/bindings/sram/sram.txt
+Warning: Documentation/devicetree/bindings/arm/arm,scpi.txt references a file that doesn't exist: Documentation/devicetree/bindings/sram/sram.txt
+Warning: Documentation/devicetree/bindings/arm/bcm/brcm,bcm63138.txt references a file that doesn't exist: Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
+Warning: Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/keys.txt
+Warning: Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt references a file that doesn't exist: Documentation/devicetree/bindings/mfd/syscon.txt
+Warning: Documentation/devicetree/bindings/arm/omap/mpu.txt references a file that doesn't exist: Documentation/devicetree/bindings/sram/sram.txt
+Warning: Documentation/devicetree/bindings/leds/register-bit-led.txt references a file that doesn't exist: Documentation/devicetree/bindings/mfd/syscon.txt
+Warning: Documentation/devicetree/bindings/memory-controllers/ti/emif.txt references a file that doesn't exist: Documentation/devicetree/bindings/sram/sram.txt
+Warning: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt references a file that doesn't exist: Documentation/devicetree/bindings/iommu/arm,smmu.txt
+Warning: Documentation/devicetree/bindings/mtd/cadence-nand-controller.txt references a file that doesn't exist: Documentation/devicetree/bindings/mtd/nand.txt
+Warning: Documentation/devicetree/bindings/net/brcm,bcm7445-switch-v4.0.txt references a file that doesn't exist: Documentation/devicetree/binding/reset/reset.txt
+Warning: Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/syscon.txt
+Warning: Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/syscon.txt
+Warning: Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/syscon.txt
+Warning: Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/syscon.txt
+Warning: Documentation/devicetree/bindings/sram/sunxi-sram.txt references a file that doesn't exist: Documentation/devicetree/bindings/sram/sram.txt
+Warning: Documentation/filesystems/automount-support.txt references a file that doesn't exist: Documentation/filesystems/autofs.txt
+Warning: Documentation/kernel-hacking/hacking.rst references a file that doesn't exist: Documentation/kbuild/namespaces.rst
+Warning: Documentation/kernel-hacking/hacking.rst references a file that doesn't exist: Documentation/kbuild/namespaces.rst
+Warning: Documentation/process/submit-checklist.rst references a file that doesn't exist: Documentation/ioctl/ioctl-number.rst
+Warning: Documentation/translations/it_IT/process/submit-checklist.rst references a file that doesn't exist: Documentation/ioctl/ioctl-number.rst
+Warning: Documentation/translations/zh_CN/process/submit-checklist.rst references a file that doesn't exist: Documentation/ioctl/ioctl-number.rst
+Warning: Documentation/virt/kvm/devices/vcpu.txt references a file that doesn't exist: Documentation/virt/kvm/arm/pvtime.txt
+Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
+Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
+Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/media/st,stm32-dcmi.txt
+Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/*/stm32-*timer*
+Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pwm/pwm-stm32*
+Warning: drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c references a file that doesn't exist: Documentation/arm/sunxi/README
+Warning: drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c references a file that doesn't exist: Documentation/arm/sunxi/README
+Warning: drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c references a file that doesn't exist: Documentation/arm/sunxi/README
+Warning: drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c references a file that doesn't exist: Documentation/arm/sunxi/README
+Warning: drivers/gpu/drm/drm_ioctl.c references a file that doesn't exist: Documentation/ioctl/botching-up-ioctls.rst
+Warning: drivers/hwtracing/coresight/Kconfig references a file that doesn't exist: Documentation/trace/coresight-cpu-debug.rst
+Warning: drivers/media/v4l2-core/v4l2-fwnode.c references a file that doesn't exist: Documentation/acpi/dsd
+Warning: drivers/staging/wfx/Documentation/devicetree/bindings/net/wireless/siliabs,wfx.txt references a file that doesn't exist: Documentation/devicetree/binding/net/ethernet.txt
+Warning: include/uapi/rdma/rdma_user_ioctl_cmds.h references a file that doesn't exist: Documentation/ioctl/ioctl-number.rst
+  SPHINX  htmldocs --> file:///home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/output
+  PARSE   include/uapi/linux/videodev2.h
+  PARSE   include/uapi/linux/cec.h
+Running Sphinx v2.2.0
+enabling CJK for LaTeX builder
+loading pickled environment... done
+building [mo]: targets for 0 po files that are out of date
+building [html]: targets for 2103 source files that are out of date
+updating environment: [extensions changed ('maintainers_include')] 2137 added, 1 changed, 10 removed
+reading sources... [  3%] PCI/acpi-info .. admin-guide/cgroup-v1/memcg_test
+/home/madhuparna/anaconda3/lib/python3.7/importlib/__init__.py:127: RemovedInSphinx30Warning: sphinx.environment.NoUri is deprecated. Check CHANGES for Sphinx API modifications.
+  return _bootstrap._gcd_import(name[level:], package, level)
+reading sources... [  6%] admin-guide/cgroup-v1/memory .. admin-guide/laptops/asus-laptop
+reading sources... [ 10%] admin-guide/laptops/disk-shock-protection .. admin-guide/ufs
+reading sources... [ 13%] admin-guide/unicode .. arm/uefi
+reading sources... [ 16%] arm/vfp/release-notes .. core-api/timekeeping
+reading sources... [ 20%] core-api/tracepoint .. driver-api/driver-model/overview
+reading sources... [ 23%] driver-api/driver-model/platform .. driver-api/men-chameleon-bus
+reading sources... [ 26%] driver-api/message-based .. driver-api/thermal/exynos_thermal
+reading sources... [ 30%] driver-api/thermal/exynos_thermal_emulation .. fb/viafb
+reading sources... [ 33%] fb/vt8623fb .. gpu/drm-mm
+reading sources... [ 36%] gpu/drm-uapi .. hwmon/ibmpowernv
+reading sources... [ 40%] hwmon/ina209 .. hwmon/powr1220
+reading sources... [ 43%] hwmon/pwm-fan .. i2c/busses/scx200_acb
+reading sources... [ 46%] i2c/dev-interface .. input/input_kapi
+reading sources... [ 50%] input/input_uapi .. media/dvb-drivers/ci
+reading sources... [ 53%] media/dvb-drivers/contributors .. media/uapi/dvb/audio-get-status
+reading sources... [ 56%] media/uapi/dvb/audio-pause .. media/uapi/dvb/fe-type-t
+reading sources... [ 60%] media/uapi/dvb/fe_property_parameters .. media/uapi/rc/lirc-dev
+reading sources... [ 63%] media/uapi/rc/lirc-dev-intro .. media/uapi/v4l/extended-controls
+reading sources... [ 66%] media/uapi/v4l/field-order .. media/uapi/v4l/pixfmt-y10b
+reading sources... [ 70%] media/uapi/v4l/pixfmt-y10p .. media/uapi/v4l/vidioc-g-input
+reading sources... [ 73%] media/uapi/v4l/vidioc-g-jpegcomp .. media/v4l-drivers/tuners
+reading sources... [ 76%] media/v4l-drivers/usbvision-cardlist .. networking/net_failover
+reading sources... [ 80%] networking/netdev-FAQ .. powerpc/ultravisor
+reading sources... [ 83%] process/1.Intro .. security/keys/trusted-encrypted
+reading sources... [ 86%] security/lsm .. target/tcmu-design
+reading sources... [ 90%] timers/highres .. translations/it_IT/process/stable-api-nonsense
+reading sources... [ 93%] translations/it_IT/process/stable-kernel-rules .. virt/kvm/arm/pvtime
+reading sources... [ 96%] virt/kvm/cpuid .. x86/orc-unwinder
+reading sources... [100%] x86/pat .. xtensa/mmu
+
+waiting for workers...
+./kernel/futex.c:1187: warning: Function parameter or member 'ret' not described in 'wait_for_owner_exiting'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_open' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_alloc' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_free' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_read' not described in 'security_list_options'
+./include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_write' not described in 'security_list_options'
+./sound/soc/soc-core.c:2509: warning: Function parameter or member 'legacy_dai_naming' not described in 'snd_soc_register_dai'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'dev_scratch' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'list' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'ip_defrag_offset' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'skb_mstamp_ns' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member '__cloned_offset' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'head_frag' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_type_offset' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'encapsulation' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'encap_hdr_csum' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'csum_valid' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member '__pkt_vlan_present_offset' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'vlan_present' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'csum_complete_sw' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'csum_level' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'inner_protocol_type' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'remcsum_offload' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'sender_cpu' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'reserved_tailroom' not described in 'sk_buff'
+./include/linux/skbuff.h:888: warning: Function parameter or member 'inner_ipproto' not described in 'sk_buff'
+./include/net/sock.h:232: warning: Function parameter or member 'skc_addrpair' not described in 'sock_common'
+./include/net/sock.h:232: warning: Function parameter or member 'skc_portpair' not described in 'sock_common'
+./include/net/sock.h:232: warning: Function parameter or member 'skc_ipv6only' not described in 'sock_common'
+./include/net/sock.h:232: warning: Function parameter or member 'skc_net_refcnt' not described in 'sock_common'
+./include/net/sock.h:232: warning: Function parameter or member 'skc_v6_daddr' not described in 'sock_common'
+./include/net/sock.h:232: warning: Function parameter or member 'skc_v6_rcv_saddr' not described in 'sock_common'
+./include/net/sock.h:232: warning: Function parameter or member 'skc_cookie' not described in 'sock_common'
+./include/net/sock.h:232: warning: Function parameter or member 'skc_listener' not described in 'sock_common'
+./include/net/sock.h:232: warning: Function parameter or member 'skc_tw_dr' not described in 'sock_common'
+./include/net/sock.h:232: warning: Function parameter or member 'skc_rcv_wnd' not described in 'sock_common'
+./include/net/sock.h:232: warning: Function parameter or member 'skc_tw_rcv_nxt' not described in 'sock_common'
+./include/net/sock.h:514: warning: Function parameter or member 'sk_rx_skb_cache' not described in 'sock'
+./include/net/sock.h:514: warning: Function parameter or member 'sk_wq_raw' not described in 'sock'
+./include/net/sock.h:514: warning: Function parameter or member 'tcp_rtx_queue' not described in 'sock'
+./include/net/sock.h:514: warning: Function parameter or member 'sk_tx_skb_cache' not described in 'sock'
+./include/net/sock.h:514: warning: Function parameter or member 'sk_route_forced_caps' not described in 'sock'
+./include/net/sock.h:514: warning: Function parameter or member 'sk_txtime_report_errors' not described in 'sock'
+./include/net/sock.h:514: warning: Function parameter or member 'sk_validate_xmit_skb' not described in 'sock'
+./include/net/sock.h:514: warning: Function parameter or member 'sk_bpf_storage' not described in 'sock'
+./include/net/sock.h:2454: warning: Function parameter or member 'tcp_rx_skb_cache_key' not described in 'DECLARE_STATIC_KEY_FALSE'
+./include/net/sock.h:2454: warning: Excess function parameter 'sk' description in 'DECLARE_STATIC_KEY_FALSE'
+./include/net/sock.h:2454: warning: Excess function parameter 'skb' description in 'DECLARE_STATIC_KEY_FALSE'
+./include/linux/netdevice.h:1779: warning: bad line:                                 spinlock
+./include/linux/netdevice.h:2077: warning: Function parameter or member 'gso_partial_features' not described in 'net_device'
+./include/linux/netdevice.h:2077: warning: Function parameter or member 'l3mdev_ops' not described in 'net_device'
+./include/linux/netdevice.h:2077: warning: Function parameter or member 'xfrmdev_ops' not described in 'net_device'
+./include/linux/netdevice.h:2077: warning: Function parameter or member 'tlsdev_ops' not described in 'net_device'
+./include/linux/netdevice.h:2077: warning: Function parameter or member 'name_assign_type' not described in 'net_device'
+./include/linux/netdevice.h:2077: warning: Function parameter or member 'ieee802154_ptr' not described in 'net_device'
+./include/linux/netdevice.h:2077: warning: Function parameter or member 'mpls_ptr' not described in 'net_device'
+./include/linux/netdevice.h:2077: warning: Function parameter or member 'xdp_prog' not described in 'net_device'
+./include/linux/netdevice.h:2077: warning: Function parameter or member 'gro_flush_timeout' not described in 'net_device'
+./include/linux/netdevice.h:2077: warning: Function parameter or member 'nf_hooks_ingress' not described in 'net_device'
+./include/linux/netdevice.h:2077: warning: Function parameter or member 'qdisc_hash' not described in 'net_device'
+./include/linux/netdevice.h:2077: warning: Function parameter or member 'xps_cpus_map' not described in 'net_device'
+./include/linux/netdevice.h:2077: warning: Function parameter or member 'xps_rxqs_map' not described in 'net_device'
+./include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising' not described in 'phylink_link_state'
+./include/linux/phylink.h:56: warning: Function parameter or member '__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertising' not described in 'phylink_link_state'
+./kernel/futex.c:1187: warning: Function parameter or member 'ret' not described in 'wait_for_owner_exiting'
+./drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found
+./drivers/usb/typec/bus.c:1: warning: 'typec_altmode_register_driver' not found
+./drivers/usb/typec/class.c:1: warning: 'typec_altmode_register_notifier' not found
+./drivers/usb/typec/class.c:1: warning: 'typec_altmode_unregister_notifier' not found
+./include/linux/regulator/machine.h:196: warning: Function parameter or member 'max_uV_step' not described in 'regulation_constraints'
+./include/linux/regulator/driver.h:223: warning: Function parameter or member 'resume' not described in 'regulator_ops'
+./include/linux/spi/spi.h:207: warning: Function parameter or member 'driver_override' not described in 'spi_device'
+./include/linux/spi/spi.h:650: warning: Function parameter or member 'irq_flags' not described in 'spi_controller'
+./fs/posix_acl.c:647: warning: Function parameter or member 'inode' not described in 'posix_acl_update_mode'
+./fs/posix_acl.c:647: warning: Function parameter or member 'mode_p' not described in 'posix_acl_update_mode'
+./fs/posix_acl.c:647: warning: Function parameter or member 'acl' not described in 'posix_acl_update_mode'
+./include/linux/jbd2.h:461: warning: bad line:         journal. These are dirty buffers and revoke descriptor blocks.
+./drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
+./drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1: warning: no structured comments found
+./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:254: warning: Function parameter or member 'hdcp_workqueue' not described in 'amdgpu_display_manager'
+./include/drm/drm_modeset_helper_vtables.h:1052: warning: Function parameter or member 'prepare_writeback_job' not described in 'drm_connector_helper_funcs'
+./include/drm/drm_modeset_helper_vtables.h:1052: warning: Function parameter or member 'cleanup_writeback_job' not described in 'drm_connector_helper_funcs'
+./include/linux/i2c.h:337: warning: Function parameter or member 'init_irq' not described in 'i2c_client'
+./drivers/infiniband/core/umem_odp.c:167: warning: Function parameter or member 'ops' not described in 'ib_umem_odp_alloc_child'
+./drivers/infiniband/core/umem_odp.c:217: warning: Function parameter or member 'ops' not described in 'ib_umem_odp_get'
+./drivers/infiniband/ulp/iser/iscsi_iser.h:401: warning: Function parameter or member 'all_list' not described in 'iser_fr_desc'
+./drivers/infiniband/ulp/iser/iscsi_iser.h:415: warning: Function parameter or member 'all_list' not described in 'iser_fr_pool'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd0' not described in 'opa_vesw_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd1' not described in 'opa_vesw_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd2' not described in 'opa_vesw_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd3' not described in 'opa_vesw_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd4' not described in 'opa_vesw_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd0' not described in 'opa_per_veswport_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd1' not described in 'opa_per_veswport_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd2' not described in 'opa_per_veswport_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd3' not described in 'opa_per_veswport_info'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:263: warning: Function parameter or member 'tbl_entries' not described in 'opa_veswport_mactable'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:342: warning: Function parameter or member 'reserved' not described in 'opa_veswport_summary_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd0' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd1' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd2' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd3' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd4' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd5' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd6' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd7' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd8' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd9' not described in 'opa_veswport_error_counters'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:460: warning: Function parameter or member 'reserved' not described in 'opa_vnic_vema_mad'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:485: warning: Function parameter or member 'reserved' not described in 'opa_vnic_notice_attr'
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:500: warning: Function parameter or member 'reserved' not described in 'opa_vnic_vema_mad_trap'
+./include/linux/input/sparse-keymap.h:43: warning: Function parameter or member 'sw' not described in 'key_entry'
+./include/net/cfg80211.h:1189: warning: Function parameter or member 'txpwr' not described in 'station_parameters'
+./include/net/mac80211.h:4081: warning: Function parameter or member 'sta_set_txpwr' not described in 'ieee80211_ops'
+./include/net/mac80211.h:2036: warning: Function parameter or member 'txpwr' not described in 'ieee80211_sta'
+./include/linux/devfreq.h:181: warning: Function parameter or member 'last_status' not described in 'devfreq'
+./drivers/devfreq/devfreq.c:1683: warning: bad line:         - Resource-managed devfreq_register_notifier()
+./drivers/devfreq/devfreq.c:1719: warning: bad line:         - Resource-managed devfreq_unregister_notifier()
+./drivers/devfreq/devfreq-event.c:355: warning: Function parameter or member 'edev' not described in 'devfreq_event_remove_edev'
+./drivers/devfreq/devfreq-event.c:355: warning: Excess function parameter 'dev' description in 'devfreq_event_remove_edev'
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/admin-guide/xfs.rst:257: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst:142: WARNING: duplicate label virt_mechanism, other instance in /home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/admin-guide/hw-vuln/mds.rst
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/admin-guide/perf/imx-ddr.rst:47: WARNING: Unexpected indentation.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/admin-guide/ras.rst:358: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/admin-guide/ras.rst:358: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/admin-guide/ras.rst:363: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/admin-guide/ras.rst:363: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:72: WARNING: Malformed table.
+Text in column margin in table line 57.
+
+=============   ============================================================
+Old kernels     zImage/Image support only.  Some very early kernels
+                may not even support a command line.
+
+Protocol 2.00   (Kernel 1.3.73) Added bzImage and initrd support, as
+                well as a formalized way to communicate between the
+                boot loader and the kernel.  setup.S made relocatable,
+                although the traditional setup area still assumed
+                writable.
+
+Protocol 2.01   (Kernel 1.3.76) Added a heap overrun warning.
+
+Protocol 2.02   (Kernel 2.4.0-test3-pre3) New command line protocol.
+                Lower the conventional memory ceiling.  No overwrite
+                of the traditional setup area, thus making booting
+                safe for systems which use the EBDA from SMM or 32-bit
+                BIOS entry points.  zImage deprecated but still
+                supported.
+
+Protocol 2.03   (Kernel 2.4.18-pre1) Explicitly makes the highest possible
+                initrd address available to the bootloader.
+
+Protocol 2.04   (Kernel 2.6.14) Extend the syssize field to four bytes.
+
+Protocol 2.05   (Kernel 2.6.20) Make protected mode kernel relocatable.
+                Introduce relocatable_kernel and kernel_alignment fields.
+
+Protocol 2.06   (Kernel 2.6.22) Added a field that contains the size of
+                the boot command line.
+
+Protocol 2.07   (Kernel 2.6.24) Added paravirtualised boot protocol.
+                Introduced hardware_subarch and hardware_subarch_data
+                and KEEP_SEGMENTS flag in load_flags.
+
+Protocol 2.08   (Kernel 2.6.26) Added crc32 checksum and ELF format
+                payload. Introduced payload_offset and payload_length
+                fields to aid in locating the payload.
+
+Protocol 2.09   (Kernel 2.6.26) Added a field of 64-bit physical
+                pointer to single linked list of struct setup_data.
+
+Protocol 2.10   (Kernel 2.6.31) Added a protocol for relaxed alignment
+                beyond the kernel_alignment added, new init_size and
+                pref_address fields.  Added extended boot loader IDs.
+
+Protocol 2.11   (Kernel 3.6) Added a field for offset of EFI handover
+                protocol entry point.
+
+Protocol 2.12   (Kernel 3.8) Added the xloadflags field and extension fields
+                to struct boot_params for loading bzImage and ramdisk
+                above 4G in 64bit.
+
+Protocol 2.13   (Kernel 3.14) Support 32- and 64-bit flags being set in
+                xloadflags to support booting a 64-bit kernel from 32-bit
+                EFI
+
+Protocol 2.14:  BURNT BY INCORRECT COMMIT ae7e1238e68f2a472a125673ab506d49158c1889
+                (x86/boot: Add ACPI RSDP address to setup_header)
+                DO NOT USE!!! ASSUME SAME AS 2.13.
+
+Protocol 2.15:  (Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
+=============   ============================================================
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:840: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:844: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:859: WARNING: Unexpected indentation.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:863: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:864: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:970: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:974: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:976: WARNING: Unexpected indentation.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:974: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:976: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:980: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:982: WARNING: Unexpected indentation.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:980: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:982: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/x86/boot.rst:986: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/usb/index.rst:5: WARNING: toctree contains reference to nonexisting document 'usb/rio'
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/usb/index.rst:5: WARNING: toctree contains reference to nonexisting document 'usb/wusb-design-overview'
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/usb/text_files.rst:22: WARNING: Include file '/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/usb/wusb-cbaf' not found or reading it failed
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/trace/kprobetrace.rst:100: WARNING: Explicit markup ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/power/pm_qos_interface.rst:12: WARNING: Unexpected indentation.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/misc-devices/xilinx_sdfec.rst:2: WARNING: Explicit markup ends without a blank line; unexpected unindent.
+./include/linux/netdevice.h:3521: WARNING: Inline emphasis start-string without end-string.
+./include/linux/netdevice.h:3521: WARNING: Inline emphasis start-string without end-string.
+./drivers/net/phy/sfp-bus.c:544: WARNING: Unexpected indentation.
+./drivers/net/phy/sfp-bus.c:584: WARNING: Unexpected indentation.
+./net/core/dev.c:5159: WARNING: Unknown target name: "page_is".
+./drivers/gpu/drm/mcde/mcde_drv.c:47: WARNING: Unexpected indentation.
+./drivers/gpu/drm/mcde/mcde_drv.c:49: WARNING: Block quote ends without a blank line; unexpected unindent.
+./drivers/message/fusion/mptbase.c:5057: WARNING: Definition list ends without a blank line; unexpected unindent.
+./include/linux/regulator/driver.h:284: WARNING: Unknown target name: "regulator_regmap_x_voltage".
+./include/linux/spi/spi.h:399: WARNING: Unexpected indentation.
+./fs/seq_file.c:40: WARNING: Inline strong start-string without end-string.
+./fs/seq_file.c:40: WARNING: Inline strong start-string without end-string.
+./fs/seq_file.c:40: WARNING: Inline strong start-string without end-string.
+./fs/seq_file.c:40: WARNING: Inline strong start-string without end-string.
+./fs/posix_acl.c:636: WARNING: Inline emphasis start-string without end-string.
+./fs/debugfs/inode.c:427: WARNING: Inline literal start-string without end-string.
+./fs/debugfs/inode.c:506: WARNING: Inline literal start-string without end-string.
+./fs/debugfs/inode.c:538: WARNING: Inline literal start-string without end-string.
+./fs/debugfs/inode.c:631: WARNING: Inline literal start-string without end-string.
+./fs/debugfs/file.c:496: WARNING: Inline literal start-string without end-string.
+./fs/debugfs/file.c:502: WARNING: Inline literal start-string without end-string.
+./fs/debugfs/file.c:581: WARNING: Inline literal start-string without end-string.
+./fs/debugfs/file.c:587: WARNING: Inline literal start-string without end-string.
+./fs/debugfs/file.c:846: WARNING: Inline literal start-string without end-string.
+./fs/debugfs/file.c:852: WARNING: Inline literal start-string without end-string.
+./fs/debugfs/file.c:899: WARNING: Inline literal start-string without end-string.
+./fs/debugfs/file.c:905: WARNING: Inline literal start-string without end-string.
+./fs/debugfs/file.c:1091: WARNING: Inline literal start-string without end-string.
+./fs/debugfs/file.c:1097: WARNING: Inline literal start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/filesystems/ubifs-authentication.rst:94: WARNING: Inline interpreted text or phrase reference start-string without end-string.
+./include/uapi/linux/firewire-cdev.h:312: WARNING: Inline literal start-string without end-string.
+./drivers/firewire/core-transaction.c:606: WARNING: Inline strong start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:425: WARNING: Unexpected indentation.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:423: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:427: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:429: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:429: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:429: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:433: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:446: WARNING: Unexpected indentation.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:440: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:440: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:447: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:449: WARNING: Definition list ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:462: WARNING: Unexpected indentation.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:460: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:462: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:465: WARNING: Block quote ends without a blank line; unexpected unindent.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:467: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:467: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:467: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:471: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/gpio/driver.rst:478: WARNING: Inline emphasis start-string without end-string.
+./include/linux/i2c.h:528: WARNING: Inline strong start-string without end-string.
+./drivers/infiniband/core/verbs.c:2523: WARNING: Unexpected indentation.
+./drivers/infiniband/core/verbs.c:2525: WARNING: Block quote ends without a blank line; unexpected unindent.
+./drivers/infiniband/core/verbs.c:2557: WARNING: Unexpected indentation.
+./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:243: WARNING: Inline strong start-string without end-string.
+./drivers/base/platform.c:133: WARNING: Unexpected indentation.
+./drivers/base/platform.c:212: WARNING: Unexpected indentation.
+./drivers/ata/libata-core.c:5950: WARNING: Unknown target name: "hw".
+./kernel/rcu/update.c:66: WARNING: Inline emphasis start-string without end-string.
+./kernel/rcu/update.c:66: WARNING: Inline emphasis start-string without end-string.
+./kernel/rcu/update.c:71: WARNING: Inline emphasis start-string without end-string.
+./kernel/rcu/update.c:83: WARNING: Inline emphasis start-string without end-string.
+./include/linux/devfreq.h:141: WARNING: Inline emphasis start-string without end-string.
+./include/linux/devfreq.h:246: WARNING: Inline emphasis start-string without end-string.
+./include/linux/devfreq.h:266: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/driver-model/driver.rst:215: WARNING: Inline emphasis start-string without end-string.
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/driver-api/driver-model/driver.rst:215: WARNING: Inline emphasis start-string without end-string.
+looking for now-outdated files... none found
+pickling environment... done
+checking consistency... /home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/admin-guide/device-mapper/dm-clone.rst: WARNING: document isn't included in any toctree
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/virt/kvm/arm/pvtime.rst: WARNING: document isn't included in any toctree
+done
+preparing documents... done
+writing output... [  3%] PCI/endpoint/index .. admin-guide/cifs/usage
+writing output... [  7%] admin-guide/clearing-warn-once .. admin-guide/mm/soft-dirty
+writing output... [ 11%] admin-guide/mm/transhuge .. arm/pxa/mfp
+writing output... [ 15%] arm/sa1100/assabet .. cdrom/index
+writing output... [ 19%] cdrom/packet-writing .. driver-api/device-io
+./include/linux/slab.h:504: WARNING: undefined label: memory-allocation (if the link has no caption the label must precede a section header)
+writing output... [ 23%] driver-api/device_connection .. driver-api/mei/mei
+writing output... [ 26%] driver-api/mei/mei-client-bus .. driver-api/thermal/power_allocator
+writing output... [ 30%] driver-api/thermal/sysfs-api .. filesystems/ext4/eainode
+writing output... [ 34%] filesystems/ext4/globals .. hwmon/ab8500
+writing output... [ 38%] hwmon/abituguru .. hwmon/ltc4245
+writing output... [ 42%] hwmon/ltc4260 .. i2c/busses/i2c-ali1535
+writing output... [ 46%] i2c/busses/i2c-ali1563 .. input/devices/pxrc
+writing output... [ 50%] input/devices/rotary-encoder .. media/dvb-drivers/bt8xx
+writing output... [ 53%] media/dvb-drivers/cards .. media/uapi/dvb/audio-set-streamtype
+writing output... [ 57%] media/uapi/dvb/audio-stop .. media/uapi/dvb/net-types
+writing output... [ 61%] media/uapi/dvb/query-dvb-frontend-info .. media/uapi/v4l/capture-example
+writing output... [ 65%] media/uapi/v4l/capture.c .. media/uapi/v4l/pixfmt-packed-yuv
+writing output... [ 69%] media/uapi/v4l/pixfmt-reserved .. media/uapi/v4l/vidioc-enum-frameintervals
+writing output... [ 73%] media/uapi/v4l/vidioc-enum-framesizes .. media/v4l-drivers/saa7134-cardlist
+writing output... [ 76%] media/v4l-drivers/saa7164-cardlist .. networking/nfc
+writing output... [ 80%] networking/phy .. process/clang-format
+writing output... [ 84%] process/code-of-conduct .. sound/cards/sb-live-mixer
+writing output... [ 88%] sound/cards/serial-u16550 .. translations/it_IT/core-api/memory-allocation
+/home/madhuparna/Desktop/linux_work/linux_mainline/Documentation/trace/kprobetrace.rst:69: WARNING: undefined label: user_mem_access (if the link has no caption the label must precede a section header)
+writing output... [ 92%] translations/it_IT/disclaimer-ita .. usb/gadget_multi
+writing output... [ 96%] usb/gadget_printer .. watchdog/wdt
+writing output... [100%] x86/amd-memory-encryption .. xtensa/mmu
+
+waiting for workers...
+generating indices...  genindexdone
+writing additional pages...  searchdone
+copying images... [  1%] RCU/Design/Data-Structures/BigTreeClassicRCU.svg
+copying images... [  2%] RCU/Design/Data-Structures/HugeTreeClassicRCU.svg
+copying images... [  4%] RCU/Design/Data-Structures/BigTreePreemptRCUBHdyntickCB.svg
+copying images... [  5%] RCU/Design/Data-Structures/TreeMapping.svg
+copying images... [  7%] RCU/Design/Data-Structures/TreeMappingLevel.svg
+copying images... [  8%] RCU/Design/Data-Structures/TreeLevel.svg
+copying images... [ 10%] RCU/Design/Data-Structures/blkd_task.svg
+copying images... [ 11%] RCU/Design/Data-Structures/nxtlist.svg
+copying images... [ 13%] RCU/Design/Expedited-Grace-Periods/ExpRCUFlow.svg
+copying images... [ 14%] RCU/Design/Expedited-Grace-Periods/ExpSchedFlow.svg
+copying images... [ 15%] RCU/Design/Expedited-Grace-Periods/Funnel0.svg
+copying images... [ 17%] RCU/Design/Expedited-Grace-Periods/Funnel1.svg
+copying images... [ 18%] RCU/Design/Expedited-Grace-Periods/Funnel2.svg
+copying images... [ 20%] RCU/Design/Expedited-Grace-Periods/Funnel3.svg
+copying images... [ 21%] RCU/Design/Expedited-Grace-Periods/Funnel4.svg
+copying images... [ 23%] RCU/Design/Expedited-Grace-Periods/Funnel5.svg
+copying images... [ 24%] RCU/Design/Expedited-Grace-Periods/Funnel6.svg
+copying images... [ 26%] RCU/Design/Expedited-Grace-Periods/Funnel7.svg
+copying images... [ 27%] RCU/Design/Expedited-Grace-Periods/Funnel8.svg
+copying images... [ 28%] RCU/Design/Memory-Ordering/rcu_node-lock.svg
+copying images... [ 30%] RCU/Design/Memory-Ordering/TreeRCU-callback-registry.svg
+copying images... [ 31%] RCU/Design/Memory-Ordering/TreeRCU-gp-init-1.svg
+copying images... [ 33%] RCU/Design/Memory-Ordering/TreeRCU-qs.svg
+copying images... [ 34%] RCU/Design/Memory-Ordering/TreeRCU-dyntick.svg
+copying images... [ 36%] RCU/Design/Memory-Ordering/TreeRCU-hotplug.svg
+copying images... [ 37%] RCU/Design/Memory-Ordering/TreeRCU-gp-fqs.svg
+copying images... [ 39%] RCU/Design/Memory-Ordering/TreeRCU-gp-cleanup.svg
+copying images... [ 40%] RCU/Design/Memory-Ordering/TreeRCU-callback-invocation.svg
+copying images... [ 42%] RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+copying images... [ 43%] RCU/Design/Requirements/GPpartitionReaders1.svg
+copying images... [ 44%] RCU/Design/Requirements/ReadersPartitionGP1.svg
+copying images... [ 46%] admin-guide/blockdev/drbd/DRBD-8.3-data-packets.svg
+copying images... [ 47%] admin-guide/blockdev/drbd/DRBD-data-packets.svg
+copying images... [ 49%] admin-guide/blockdev/drbd/conn-states-8.dot
+copying images... [ 50%] admin-guide/blockdev/drbd/disk-states-8.dot
+copying images... [ 52%] admin-guide/blockdev/drbd/node-states-8.dot
+copying images... [ 53%] doc-guide/svg_image.svg
+copying images... [ 55%] doc-guide/hello.dot
+copying images... [ 56%] gpu/dp-mst/topology-figure-1.dot
+copying images... [ 57%] gpu/dp-mst/topology-figure-2.dot
+copying images... [ 59%] gpu/dp-mst/topology-figure-3.dot
+copying images... [ 60%] input/shape.svg
+copying images... [ 62%] input/interactive.svg
+copying images... [ 63%] media/typical_media_device.svg
+copying images... [ 65%] media/uapi/dvb/dvbstb.svg
+copying images... [ 66%] media/uapi/v4l/crop.svg
+copying images... [ 68%] media/uapi/v4l/vbi_hsync.svg
+copying images... [ 69%] media/uapi/v4l/vbi_525.svg
+copying images... [ 71%] media/uapi/v4l/vbi_625.svg
+copying images... [ 72%] media/uapi/v4l/pipeline.dot
+copying images... [ 73%] media/uapi/v4l/subdev-image-processing-crop.svg
+copying images... [ 75%] media/uapi/v4l/subdev-image-processing-scaling-multi-source.svg
+copying images... [ 76%] media/uapi/v4l/subdev-image-processing-full.svg
+copying images... [ 78%] media/uapi/v4l/fieldseq_tb.svg
+copying images... [ 79%] media/uapi/v4l/fieldseq_bt.svg
+copying images... [ 81%] media/uapi/v4l/nv12mt.svg
+copying images... [ 82%] media/uapi/v4l/nv12mt_example.svg
+copying images... [ 84%] media/uapi/v4l/selection.svg
+copying images... [ 85%] media/uapi/v4l/bayer.svg
+copying images... [ 86%] media/uapi/v4l/constraints.svg
+copying images... [ 88%] media/v4l-drivers/ipu3_rcb.svg
+copying images... [ 89%] media/v4l-drivers/qcom_camss_graph.dot
+copying images... [ 91%] media/v4l-drivers/qcom_camss_8x96_graph.dot
+copying images... [ 92%] media/v4l-drivers/vimc.dot
+copying images... [ 94%] networking/tls-offload-layers.svg
+copying images... [ 95%] networking/tls-offload-reorder-good.svg
+copying images... [ 97%] networking/tls-offload-reorder-bad.svg
+copying images... [ 98%] translations/it_IT/doc-guide/../../../doc-guide/svg_image.svg
+copying images... [100%] translations/it_IT/doc-guide/../../../doc-guide/hello.dot
+
+copying static files... ... done
+copying extra files... done
+dumping search index in English (code: en)... done
+dumping object inventory... done
+build succeeded, 103 warnings.
+
+The HTML pages are in Documentation/output.
+/home/madhuparna/anaconda3/lib/python3.7/site-packages/sphinx_rtd_theme/search.html:20: RemovedInSphinx30Warning: To modify script_files in the theme is deprecated. Please insert a <script> tag directly in your theme instead.
+  {{ super() }}
diff --git a/four.txt b/four.txt
new file mode 100644
index 000000000000..30da117f635a
--- /dev/null
+++ b/four.txt
@@ -0,0 +1,7656 @@
+scripts/kconfig/conf  --syncconfig Kconfig
+  HOSTCC  scripts/selinux/genheaders/genheaders
+  HOSTCC  scripts/selinux/mdp/mdp
+  CHECK   scripts/mod/empty.c
+  CC      scripts/mod/devicetable-offsets.s
+  CC      kernel/bounds.s
+  CC      arch/x86/kernel/asm-offsets.s
+  CALL    scripts/checksyscalls.sh
+  CALL    scripts/atomic/check-atomics.sh
+  DESCEND  objtool
+  GEN      /home/madhuparna/Desktop/linux_work/linux_mainline/tools/objtool/arch/x86/lib/inat-tables.c
+  CC       /home/madhuparna/Desktop/linux_work/linux_mainline/tools/objtool/arch/x86/decode.o
+  LD       /home/madhuparna/Desktop/linux_work/linux_mainline/tools/objtool/arch/x86/objtool-in.o
+  LD       /home/madhuparna/Desktop/linux_work/linux_mainline/tools/objtool/objtool-in.o
+/home/madhuparna/Desktop/linux_work/linux_mainline/tools/objtool
+  LINK     /home/madhuparna/Desktop/linux_work/linux_mainline/tools/objtool/objtool
+  HDRINST usr/include/drm/exynos_drm.h
+  HDRINST usr/include/drm/drm_fourcc.h
+  HDRINST usr/include/drm/drm.h
+  HDRINST usr/include/drm/v3d_drm.h
+  HDRINST usr/include/drm/i915_drm.h
+  HDRINST usr/include/drm/vmwgfx_drm.h
+  HDRINST usr/include/drm/amdgpu_drm.h
+  HDRINST usr/include/drm/omap_drm.h
+  HDRINST usr/include/asm-generic/sembuf.h
+  HDRINST usr/include/asm-generic/posix_types.h
+  HDRINST usr/include/asm-generic/msgbuf.h
+  HDRINST usr/include/asm-generic/shmbuf.h
+  HDRINST usr/include/rdma/nes-abi.h
+  HDRINST usr/include/rdma/cxgb3-abi.h
+  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
+  HDRINST usr/include/rdma/efa-abi.h
+  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
+  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
+  HDRINST usr/include/rdma/qedr-abi.h
+  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
+  HDRINST usr/include/misc/habanalabs.h
+  HDRINST usr/include/misc/fastrpc.h
+  HDRINST usr/include/linux/io_uring.h
+  HDRINST usr/include/linux/magic.h
+  HDRINST usr/include/linux/seccomp.h
+  HDRINST usr/include/linux/errqueue.h
+  HDRINST usr/include/linux/msg.h
+  HDRINST usr/include/linux/ppp_defs.h
+  HDRINST usr/include/linux/gpio.h
+  HDRINST usr/include/linux/ppp-ioctl.h
+  HDRINST usr/include/linux/resource.h
+  HDRINST usr/include/linux/audit.h
+  HDRINST usr/include/linux/utime.h
+  HDRINST usr/include/linux/elfcore.h
+  HDRINST usr/include/linux/shm.h
+  HDRINST usr/include/linux/time.h
+  HDRINST usr/include/linux/cyclades.h
+  HDRINST usr/include/linux/sem.h
+  HDRINST usr/include/linux/input-event-codes.h
+  HDRINST usr/include/linux/time_types.h
+  HDRINST usr/include/asm/sembuf.h
+  HDRINST usr/include/asm/msgbuf.h
+  HDRINST usr/include/asm/shmbuf.h
+  CHECK   init/main.c
+init/main.c:173:12: warning: symbol 'envp_init' was not declared. Should it be static?
+  CC      init/main.o
+  CHK     include/generated/compile.h
+  CHECK   init/version.c
+  CC      init/version.o
+  CHECK   init/do_mounts.c
+init/do_mounts.c:393:30: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts.c:393:30:    expected char const [noderef] <asn:1> *dev_name
+init/do_mounts.c:393:30:    got char *name
+init/do_mounts.c:393:36: warning: incorrect type in argument 2 (different address spaces)
+init/do_mounts.c:393:36:    expected char const [noderef] <asn:1> *dir_name
+init/do_mounts.c:393:36:    got char *
+init/do_mounts.c:393:45: warning: incorrect type in argument 3 (different address spaces)
+init/do_mounts.c:393:45:    expected char const [noderef] <asn:1> *type
+init/do_mounts.c:393:45:    got char *fs
+init/do_mounts.c:393:56: warning: incorrect type in argument 5 (different address spaces)
+init/do_mounts.c:393:56:    expected void [noderef] <asn:1> *data
+init/do_mounts.c:393:56:    got void *data
+init/do_mounts.c:397:20: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts.c:397:20:    expected char const [noderef] <asn:1> *filename
+init/do_mounts.c:397:20:    got char *
+init/do_mounts.h:19:21: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts.h:19:21:    expected char const [noderef] <asn:1> *pathname
+init/do_mounts.h:19:21:    got char *name
+init/do_mounts.h:20:27: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts.h:20:27:    expected char const [noderef] <asn:1> *filename
+init/do_mounts.h:20:27:    got char *name
+init/do_mounts.c:674:20: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts.c:674:20:    expected char const [noderef] <asn:1> *dev_name
+init/do_mounts.c:674:20:    got char *
+init/do_mounts.c:674:25: warning: incorrect type in argument 2 (different address spaces)
+init/do_mounts.c:674:25:    expected char const [noderef] <asn:1> *dir_name
+init/do_mounts.c:674:25:    got char *
+init/do_mounts.c:675:21: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts.c:675:21:    expected char const [noderef] <asn:1> *filename
+init/do_mounts.c:675:21:    got char *
+  CC      init/do_mounts.o
+  CHECK   init/do_mounts_initrd.c
+init/do_mounts_initrd.c:52:19: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:52:19:    expected char const [noderef] <asn:1> *filename
+init/do_mounts_initrd.c:52:19:    got char *
+init/do_mounts_initrd.c:56:20: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:56:20:    expected char const [noderef] <asn:1> *filename
+init/do_mounts_initrd.c:56:20:    got char *
+init/do_mounts_initrd.c:57:20: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:57:20:    expected char const [noderef] <asn:1> *dev_name
+init/do_mounts_initrd.c:57:20:    got char *
+init/do_mounts_initrd.c:57:25: warning: incorrect type in argument 2 (different address spaces)
+init/do_mounts_initrd.c:57:25:    expected char const [noderef] <asn:1> *dir_name
+init/do_mounts_initrd.c:57:25:    got char *
+init/do_mounts_initrd.c:58:21: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:58:21:    expected char const [noderef] <asn:1> *filename
+init/do_mounts_initrd.c:58:21:    got char *
+init/do_mounts.h:19:21: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts.h:19:21:    expected char const [noderef] <asn:1> *pathname
+init/do_mounts.h:19:21:    got char *name
+init/do_mounts.h:20:27: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts.h:20:27:    expected char const [noderef] <asn:1> *filename
+init/do_mounts.h:20:27:    got char *name
+init/do_mounts_initrd.c:74:20: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:74:20:    expected char const [noderef] <asn:1> *pathname
+init/do_mounts_initrd.c:74:20:    got char *
+init/do_mounts_initrd.c:75:20: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:75:20:    expected char const [noderef] <asn:1> *filename
+init/do_mounts_initrd.c:75:20:    got char *
+init/do_mounts_initrd.c:92:20: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:92:20:    expected char const [noderef] <asn:1> *dev_name
+init/do_mounts_initrd.c:92:20:    got char *
+init/do_mounts_initrd.c:92:26: warning: incorrect type in argument 2 (different address spaces)
+init/do_mounts_initrd.c:92:26:    expected char const [noderef] <asn:1> *dir_name
+init/do_mounts_initrd.c:92:26:    got char *
+init/do_mounts_initrd.c:94:21: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:94:21:    expected char const [noderef] <asn:1> *filename
+init/do_mounts_initrd.c:94:21:    got char *
+init/do_mounts_initrd.c:97:28: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:97:28:    expected char const [noderef] <asn:1> *filename
+init/do_mounts_initrd.c:97:28:    got char *
+init/do_mounts_initrd.c:101:20: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:101:20:    expected char const [noderef] <asn:1> *filename
+init/do_mounts_initrd.c:101:20:    got char *
+init/do_mounts_initrd.c:106:28: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:106:28:    expected char const [noderef] <asn:1> *dev_name
+init/do_mounts_initrd.c:106:28:    got char *
+init/do_mounts_initrd.c:106:36: warning: incorrect type in argument 2 (different address spaces)
+init/do_mounts_initrd.c:106:36:    expected char const [noderef] <asn:1> *dir_name
+init/do_mounts_initrd.c:106:36:    got char *
+init/do_mounts_initrd.c:110:36: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:110:36:    expected char const [noderef] <asn:1> *filename
+init/do_mounts_initrd.c:110:36:    got char *
+init/do_mounts_initrd.c:116:29: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:116:29:    expected char [noderef] <asn:1> *name
+init/do_mounts_initrd.c:116:29:    got char *
+init/do_mounts.h:19:21: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts.h:19:21:    expected char const [noderef] <asn:1> *pathname
+init/do_mounts.h:19:21:    got char *name
+init/do_mounts.h:20:27: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts.h:20:27:    expected char const [noderef] <asn:1> *filename
+init/do_mounts.h:20:27:    got char *name
+init/do_mounts_initrd.c:139:37: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:139:37:    expected char const [noderef] <asn:1> *pathname
+init/do_mounts_initrd.c:139:37:    got char *
+init/do_mounts_initrd.c:144:21: warning: incorrect type in argument 1 (different address spaces)
+init/do_mounts_initrd.c:144:21:    expected char const [noderef] <asn:1> *pathname
+init/do_mounts_initrd.c:144:21:    got char *
+  CC      init/do_mounts_initrd.o
+  CHECK   init/initramfs.c
+init/initramfs.c:21:45: warning: incorrect type in argument 2 (different address spaces)
+init/initramfs.c:21:45:    expected char const [noderef] <asn:1> *buf
+init/initramfs.c:21:45:    got char const *p
+init/initramfs.c:112:36: warning: incorrect type in argument 2 (different address spaces)
+init/initramfs.c:112:36:    expected char const [noderef] <asn:1> *filename
+init/initramfs.c:112:36:    got char *filename
+init/initramfs.c:299:24: warning: incorrect type in argument 1 (different address spaces)
+init/initramfs.c:299:24:    expected char const [noderef] <asn:1> *name
+init/initramfs.c:299:24:    got char *path
+init/initramfs.c:301:36: warning: incorrect type in argument 1 (different address spaces)
+init/initramfs.c:301:36:    expected char const [noderef] <asn:1> *pathname
+init/initramfs.c:301:36:    got char *path
+init/initramfs.c:303:37: warning: incorrect type in argument 1 (different address spaces)
+init/initramfs.c:303:37:    expected char const [noderef] <asn:1> *pathname
+init/initramfs.c:303:37:    got char *path
+init/initramfs.c:313:43: warning: incorrect type in argument 1 (different address spaces)
+init/initramfs.c:313:43:    expected char const [noderef] <asn:1> *oldname
+init/initramfs.c:313:43:    got char *old
+init/initramfs.c:313:48: warning: incorrect type in argument 2 (different address spaces)
+init/initramfs.c:313:48:    expected char const [noderef] <asn:1> *newname
+init/initramfs.c:313:48:    got char *static [toplevel] [assigned] collected
+init/initramfs.c:336:41: warning: incorrect type in argument 1 (different address spaces)
+init/initramfs.c:336:41:    expected char const [noderef] <asn:1> *filename
+init/initramfs.c:336:41:    got char *static [toplevel] [assigned] collected
+init/initramfs.c:348:28: warning: incorrect type in argument 1 (different address spaces)
+init/initramfs.c:348:28:    expected char const [noderef] <asn:1> *pathname
+init/initramfs.c:348:28:    got char *static [toplevel] [assigned] collected
+init/initramfs.c:349:28: warning: incorrect type in argument 1 (different address spaces)
+init/initramfs.c:349:28:    expected char const [noderef] <asn:1> *filename
+init/initramfs.c:349:28:    got char *static [toplevel] [assigned] collected
+init/initramfs.c:350:28: warning: incorrect type in argument 1 (different address spaces)
+init/initramfs.c:350:28:    expected char const [noderef] <asn:1> *filename
+init/initramfs.c:350:28:    got char *static [toplevel] [assigned] collected
+init/initramfs.c:355:36: warning: incorrect type in argument 1 (different address spaces)
+init/initramfs.c:355:36:    expected char const [noderef] <asn:1> *filename
+init/initramfs.c:355:36:    got char *static [toplevel] [assigned] collected
+init/initramfs.c:356:36: warning: incorrect type in argument 1 (different address spaces)
+init/initramfs.c:356:36:    expected char const [noderef] <asn:1> *filename
+init/initramfs.c:356:36:    got char *static [toplevel] [assigned] collected
+init/initramfs.c:357:36: warning: incorrect type in argument 1 (different address spaces)
+init/initramfs.c:357:36:    expected char const [noderef] <asn:1> *filename
+init/initramfs.c:357:36:    got char *static [toplevel] [assigned] collected
+init/initramfs.c:388:32: warning: incorrect type in argument 1 (different address spaces)
+init/initramfs.c:388:32:    expected char const [noderef] <asn:1> *oldname
+init/initramfs.c:388:32:    got char *
+init/initramfs.c:388:53: warning: incorrect type in argument 2 (different address spaces)
+init/initramfs.c:388:53:    expected char const [noderef] <asn:1> *newname
+init/initramfs.c:388:53:    got char *static [toplevel] [assigned] collected
+init/initramfs.c:389:21: warning: incorrect type in argument 1 (different address spaces)
+init/initramfs.c:389:21:    expected char const [noderef] <asn:1> *filename
+init/initramfs.c:389:21:    got char *static [toplevel] [assigned] collected
+  CC      init/initramfs.o
+  CHECK   init/calibrate.c
+  CC      init/calibrate.o
+  CHECK   init/init_task.c
+init/init_task.c:97:28: warning: incorrect type in initializer (different address spaces)
+init/init_task.c:97:28:    expected struct task_struct [noderef] <asn:4> *real_parent
+init/init_task.c:97:28:    got struct task_struct *
+init/init_task.c:98:28: warning: incorrect type in initializer (different address spaces)
+init/init_task.c:98:28:    expected struct task_struct [noderef] <asn:4> *parent
+init/init_task.c:98:28:    got struct task_struct *
+  CC      init/init_task.o
+  AR      init/built-in.a
+  AS      usr/initramfs_data.o
+  AR      usr/built-in.a
+  CC      usr/include/video/uvesafb.h.s
+  CC      usr/include/video/sisfb.h.s
+  CC      usr/include/drm/tegra_drm.h.s
+  CC      usr/include/drm/drm.h.s
+  CC      usr/include/drm/drm_sarea.h.s
+  CC      usr/include/drm/vgem_drm.h.s
+  CC      usr/include/drm/i915_drm.h.s
+  CC      usr/include/drm/v3d_drm.h.s
+  CC      usr/include/drm/lima_drm.h.s
+  CC      usr/include/drm/nouveau_drm.h.s
+  CC      usr/include/drm/radeon_drm.h.s
+  CC      usr/include/drm/etnaviv_drm.h.s
+  CC      usr/include/drm/r128_drm.h.s
+  CC      usr/include/drm/i810_drm.h.s
+  CC      usr/include/drm/panfrost_drm.h.s
+  CC      usr/include/drm/qxl_drm.h.s
+  CC      usr/include/drm/drm_mode.h.s
+  CC      usr/include/drm/exynos_drm.h.s
+  CC      usr/include/drm/savage_drm.h.s
+  CC      usr/include/drm/msm_drm.h.s
+  CC      usr/include/drm/vc4_drm.h.s
+  CC      usr/include/drm/via_drm.h.s
+  CC      usr/include/drm/mga_drm.h.s
+  CC      usr/include/drm/sis_drm.h.s
+  CC      usr/include/drm/omap_drm.h.s
+  CC      usr/include/drm/amdgpu_drm.h.s
+  CC      usr/include/drm/armada_drm.h.s
+  CC      usr/include/drm/drm_fourcc.h.s
+  CC      usr/include/drm/virtgpu_drm.h.s
+  CC      usr/include/asm/bpf_perf_event.h.s
+  CC      usr/include/asm/termios.h.s
+  CC      usr/include/asm/mce.h.s
+  CC      usr/include/asm/siginfo.h.s
+  CC      usr/include/asm/msr.h.s
+  CC      usr/include/asm/posix_types_64.h.s
+  CC      usr/include/asm/socket.h.s
+  CC      usr/include/asm/swab.h.s
+  CC      usr/include/asm/kvm_perf.h.s
+  CC      usr/include/asm/kvm.h.s
+  CC      usr/include/asm/bootparam.h.s
+  CC      usr/include/asm/sigcontext32.h.s
+  CC      usr/include/asm/posix_types.h.s
+  CC      usr/include/asm/ist.h.s
+  CC      usr/include/asm/mtrr.h.s
+  CC      usr/include/asm/kvm_para.h.s
+  CC      usr/include/asm/byteorder.h.s
+  CC      usr/include/asm/statfs.h.s
+  CC      usr/include/asm/posix_types_x32.h.s
+  CC      usr/include/asm/ptrace-abi.h.s
+  CC      usr/include/asm/stat.h.s
+  CC      usr/include/asm/e820.h.s
+  CC      usr/include/asm/fcntl.h.s
+  CC      usr/include/asm/ptrace.h.s
+  CC      usr/include/asm/termbits.h.s
+  CC      usr/include/asm/posix_types_32.h.s
+  CC      usr/include/asm/sigcontext.h.s
+  CC      usr/include/mtd/ubi-user.h.s
+  CC      usr/include/mtd/mtd-abi.h.s
+  CC      usr/include/mtd/inftl-user.h.s
+  CC      usr/include/mtd/mtd-user.h.s
+  CC      usr/include/mtd/nftl-user.h.s
+  CC      usr/include/xen/gntalloc.h.s
+  CC      usr/include/rdma/qedr-abi.h.s
+  CC      usr/include/rdma/vmw_pvrdma-abi.h.s
+  CC      usr/include/rdma/ib_user_mad.h.s
+  CC      usr/include/rdma/nes-abi.h.s
+  CC      usr/include/rdma/ib_user_verbs.h.s
+  CC      usr/include/rdma/siw-abi.h.s
+  CC      usr/include/rdma/cxgb3-abi.h.s
+  CC      usr/include/rdma/hns-abi.h.s
+  CC      usr/include/rdma/ib_user_ioctl_verbs.h.s
+  CC      usr/include/rdma/rdma_user_rxe.h.s
+  CC      usr/include/rdma/i40iw-abi.h.s
+  CC      usr/include/rdma/rdma_user_ioctl.h.s
+  CC      usr/include/rdma/bnxt_re-abi.h.s
+  CC      usr/include/rdma/mlx4-abi.h.s
+  CC      usr/include/rdma/mlx5_user_ioctl_cmds.h.s
+  CC      usr/include/rdma/rdma_user_ioctl_cmds.h.s
+  CC      usr/include/rdma/ib_user_sa.h.s
+  CC      usr/include/rdma/rdma_netlink.h.s
+  CC      usr/include/rdma/efa-abi.h.s
+  CC      usr/include/rdma/cxgb4-abi.h.s
+  CC      usr/include/rdma/mlx5-abi.h.s
+  CC      usr/include/rdma/ocrdma-abi.h.s
+  CC      usr/include/rdma/rvt-abi.h.s
+  CC      usr/include/rdma/mthca-abi.h.s
+  CC      usr/include/rdma/mlx5_user_ioctl_verbs.h.s
+  CC      usr/include/rdma/rdma_user_cm.h.s
+  CC      usr/include/misc/xilinx_sdfec.h.s
+  CC      usr/include/misc/cxl.h.s
+  CC      usr/include/misc/ocxl.h.s
+  CC      usr/include/misc/fastrpc.h.s
+  CC      usr/include/misc/habanalabs.h.s
+  CC      usr/include/linux/zorro.h.s
+  CC      usr/include/linux/max2175.h.s
+  CC      usr/include/linux/pfkeyv2.h.s
+  CC      usr/include/linux/nfs_mount.h.s
+  CC      usr/include/linux/ethtool.h.s
+  CC      usr/include/linux/tls.h.s
+  CC      usr/include/linux/inet_diag.h.s
+  CC      usr/include/linux/atm_tcp.h.s
+  CC      usr/include/linux/udmabuf.h.s
+  CC      usr/include/linux/btf.h.s
+  CC      usr/include/linux/rpmsg.h.s
+  CC      usr/include/linux/btrfs_tree.h.s
+  CC      usr/include/linux/filter.h.s
+  CC      usr/include/linux/auto_dev-ioctl.h.s
+  CC      usr/include/linux/if_macsec.h.s
+  CC      usr/include/linux/rseq.h.s
+  CC      usr/include/linux/fiemap.h.s
+  CC      usr/include/linux/smc_diag.h.s
+  CC      usr/include/linux/magic.h.s
+  CC      usr/include/linux/atmdev.h.s
+  CC      usr/include/linux/hiddev.h.s
+  CC      usr/include/linux/agpgart.h.s
+  CC      usr/include/linux/if_link.h.s
+  CC      usr/include/linux/wireless.h.s
+  CC      usr/include/linux/fscrypt.h.s
+  CC      usr/include/linux/if_hippi.h.s
+  CC      usr/include/linux/posix_types.h.s
+  CC      usr/include/linux/audit.h.s
+  CC      usr/include/linux/rds.h.s
+  CC      usr/include/linux/fsverity.h.s
+  CC      usr/include/linux/pr.h.s
+  CC      usr/include/linux/aspeed-lpc-ctrl.h.s
+  CC      usr/include/linux/dns_resolver.h.s
+  CC      usr/include/linux/gen_stats.h.s
+  CC      usr/include/linux/atmppp.h.s
+  CC      usr/include/linux/mdio.h.s
+  CC      usr/include/linux/stm.h.s
+  CC      usr/include/linux/xdp_diag.h.s
+  CC      usr/include/linux/virtio_rng.h.s
+  CC      usr/include/linux/kd.h.s
+  CC      usr/include/linux/qnx4_fs.h.s
+  CC      usr/include/linux/bcache.h.s
+  CC      usr/include/linux/llc.h.s
+  CC      usr/include/linux/perf_event.h.s
+  CC      usr/include/linux/batadv_packet.h.s
+  CC      usr/include/linux/cgroupstats.h.s
+  CC      usr/include/linux/atmlec.h.s
+  CC      usr/include/linux/if_bridge.h.s
+  CC      usr/include/linux/virtio_pci.h.s
+  CC      usr/include/linux/bfs_fs.h.s
+  CC      usr/include/linux/dccp.h.s
+  CC      usr/include/linux/dma-buf.h.s
+  CC      usr/include/linux/if_ppp.h.s
+  CC      usr/include/linux/in.h.s
+  CC      usr/include/linux/isst_if.h.s
+  CC      usr/include/linux/net_tstamp.h.s
+  CC      usr/include/linux/nilfs2_ondisk.h.s
+  CC      usr/include/linux/reiserfs_fs.h.s
+  CC      usr/include/linux/atm.h.s
+  CC      usr/include/linux/psp-sev.h.s
+  CC      usr/include/linux/sed-opal.h.s
+  CC      usr/include/linux/fanotify.h.s
+  CC      usr/include/linux/quota.h.s
+  CC      usr/include/linux/packet_diag.h.s
+  CC      usr/include/linux/ptp_clock.h.s
+  CC      usr/include/linux/mroute.h.s
+  CC      usr/include/linux/nexthop.h.s
+  CC      usr/include/linux/firewire-cdev.h.s
+  CC      usr/include/linux/netfilter_ipv4.h.s
+  CC      usr/include/linux/time.h.s
+  CC      usr/include/linux/rio_cm_cdev.h.s
+  CC      usr/include/linux/auto_fs4.h.s
+  CC      usr/include/linux/vbox_vmmdev_types.h.s
+  CC      usr/include/linux/ipsec.h.s
+  CC      usr/include/linux/posix_acl_xattr.h.s
+  CC      usr/include/linux/l2tp.h.s
+  CC      usr/include/linux/adfs_fs.h.s
+  CC      usr/include/linux/pps.h.s
+  CC      usr/include/linux/time_types.h.s
+  CC      usr/include/linux/selinux_netlink.h.s
+  CC      usr/include/linux/jffs2.h.s
+  CC      usr/include/linux/io_uring.h.s
+  CC      usr/include/linux/seccomp.h.s
+  CC      usr/include/linux/dm-log-userspace.h.s
+  CC      usr/include/linux/vm_sockets_diag.h.s
+  CC      usr/include/linux/igmp.h.s
+  CC      usr/include/linux/lightnvm.h.s
+  CC      usr/include/linux/serial.h.s
+  CC      usr/include/linux/if_tun.h.s
+  CC      usr/include/linux/virtio_console.h.s
+  CC      usr/include/linux/udp.h.s
+  CC      usr/include/linux/neighbour.h.s
+  CC      usr/include/linux/wmi.h.s
+  CC      usr/include/linux/ppp-ioctl.h.s
+  CC      usr/include/linux/switchtec_ioctl.h.s
+  CC      usr/include/linux/nfs_idmap.h.s
+  CC      usr/include/linux/efs_fs_sb.h.s
+  CC      usr/include/linux/unix_diag.h.s
+  CC      usr/include/linux/tcp_metrics.h.s
+  CC      usr/include/linux/if_arcnet.h.s
+  CC      usr/include/linux/inotify.h.s
+  CC      usr/include/linux/tcp.h.s
+  CC      usr/include/linux/dcbnl.h.s
+  CC      usr/include/linux/netfilter.h.s
+  CC      usr/include/linux/if_fddi.h.s
+  CC      usr/include/linux/input-event-codes.h.s
+  CC      usr/include/linux/mpls.h.s
+  CC      usr/include/linux/kcmp.h.s
+  CC      usr/include/linux/fs.h.s
+  CC      usr/include/linux/icmp.h.s
+  CC      usr/include/linux/route.h.s
+  CC      usr/include/linux/virtio_vsock.h.s
+  CC      usr/include/linux/pkt_sched.h.s
+  CC      usr/include/linux/dqblk_xfs.h.s
+  CC      usr/include/linux/bpf_perf_event.h.s
+  CC      usr/include/linux/dlm.h.s
+  CC      usr/include/linux/nubus.h.s
+  CC      usr/include/linux/gfs2_ondisk.h.s
+  CC      usr/include/linux/openvswitch.h.s
+  CC      usr/include/linux/userfaultfd.h.s
+  CC      usr/include/linux/uuid.h.s
+  CC      usr/include/linux/vsockmon.h.s
+  CC      usr/include/linux/qnxtypes.h.s
+  CC      usr/include/linux/ipv6_route.h.s
+  CC      usr/include/linux/virtio_balloon.h.s
+  CC      usr/include/linux/fib_rules.h.s
+  CC      usr/include/linux/sound.h.s
+  CC      usr/include/linux/seg6.h.s
+  CC      usr/include/linux/seg6_local.h.s
+  CC      usr/include/linux/scif_ioctl.h.s
+  CC      usr/include/linux/mtio.h.s
+  CC      usr/include/linux/nfs.h.s
+  CC      usr/include/linux/ip6_tunnel.h.s
+  CC      usr/include/linux/bpfilter.h.s
+  CC      usr/include/linux/cryptouser.h.s
+  CC      usr/include/linux/input.h.s
+  CC      usr/include/linux/kvm_para.h.s
+  CC      usr/include/linux/virtio_blk.h.s
+  CC      usr/include/linux/iso_fs.h.s
+  CC      usr/include/linux/capability.h.s
+  CC      usr/include/linux/cec-funcs.h.s
+  CC      usr/include/linux/netfilter_decnet.h.s
+  CC      usr/include/linux/virtio_ring.h.s
+  CC      usr/include/linux/affs_hardblocks.h.s
+  CC      usr/include/linux/nl80211.h.s
+  CC      usr/include/linux/netconf.h.s
+  CC      usr/include/linux/kfd_ioctl.h.s
+  CC      usr/include/linux/gsmmux.h.s
+  CC      usr/include/linux/termios.h.s
+  CC      usr/include/linux/seg6_hmac.h.s
+  CC      usr/include/linux/cm4000_cs.h.s
+  CC      usr/include/linux/cn_proc.h.s
+  CC      usr/include/linux/netfilter_arp.h.s
+  CC      usr/include/linux/icmpv6.h.s
+  CC      usr/include/linux/lirc.h.s
+  CC      usr/include/linux/target_core_user.h.s
+  CC      usr/include/linux/nilfs2_api.h.s
+  CC      usr/include/linux/pkt_cls.h.s
+  CC      usr/include/linux/dm-ioctl.h.s
+  CC      usr/include/linux/atm_idt77105.h.s
+  CC      usr/include/linux/if_arp.h.s
+  CC      usr/include/linux/msg.h.s
+  CC      usr/include/linux/nvme_ioctl.h.s
+  CC      usr/include/linux/romfs_fs.h.s
+  CC      usr/include/linux/media.h.s
+  CC      usr/include/linux/virtio_crypto.h.s
+  CC      usr/include/linux/signalfd.h.s
+  CC      usr/include/linux/netdevice.h.s
+  CC      usr/include/linux/kernel.h.s
+  CC      usr/include/linux/msdos_fs.h.s
+  CC      usr/include/linux/xfrm.h.s
+  CC      usr/include/linux/btrfs.h.s
+  CC      usr/include/linux/edd.h.s
+  CC      usr/include/linux/hyperv.h.s
+  CC      usr/include/linux/rtnetlink.h.s
+  CC      usr/include/linux/sonypi.h.s
+  CC      usr/include/linux/kcov.h.s
+  CC      usr/include/linux/if_tunnel.h.s
+  CC      usr/include/linux/bpf.h.s
+  CC      usr/include/linux/virtio_types.h.s
+  CC      usr/include/linux/keyctl.h.s
+  CC      usr/include/linux/acct.h.s
+  CC      usr/include/linux/mic_ioctl.h.s
+  CC      usr/include/linux/seg6_iptunnel.h.s
+  CC      usr/include/linux/fb.h.s
+  CC      usr/include/linux/rio_mport_cdev.h.s
+  CC      usr/include/linux/erspan.h.s
+  CC      usr/include/linux/dlm_netlink.h.s
+  CC      usr/include/linux/sem.h.s
+  CC      usr/include/linux/synclink.h.s
+  CC      usr/include/linux/mii.h.s
+  CC      usr/include/linux/net_dropmon.h.s
+  CC      usr/include/linux/swab.h.s
+  CC      usr/include/linux/rfkill.h.s
+  CC      usr/include/linux/tipc.h.s
+  CC      usr/include/linux/suspend_ioctls.h.s
+  CC      usr/include/linux/ip_vs.h.s
+  CC      usr/include/linux/dlm_plock.h.s
+  CC      usr/include/linux/netfilter_ipv6.h.s
+  CC      usr/include/linux/i2c-dev.h.s
+  CC      usr/include/linux/virtio_config.h.s
+  CC      usr/include/linux/atmsvc.h.s
+  CC      usr/include/linux/watchdog.h.s
+  CC      usr/include/linux/auto_fs.h.s
+  CC      usr/include/linux/uhid.h.s
+  CC      usr/include/linux/in6.h.s
+  CC      usr/include/linux/iommu.h.s
+  CC      usr/include/linux/elf-fdpic.h.s
+  CC      usr/include/linux/ivtvfb.h.s
+  CC      usr/include/linux/netlink_diag.h.s
+  CC      usr/include/linux/sysinfo.h.s
+  CC      usr/include/linux/uinput.h.s
+  CC      usr/include/linux/capi.h.s
+  CC      usr/include/linux/tee.h.s
+  CC      usr/include/linux/taskstats.h.s
+  CC      usr/include/linux/elf.h.s
+  CC      usr/include/linux/virtio_9p.h.s
+  CC      usr/include/linux/tipc_config.h.s
+  CC      usr/include/linux/vboxguest.h.s
+  CC      usr/include/linux/virtio_pmem.h.s
+  CC      usr/include/linux/kvm.h.s
+  CC      usr/include/linux/sock_diag.h.s
+  CC      usr/include/linux/qrtr.h.s
+  CC      usr/include/linux/sync_file.h.s
+  CC      usr/include/linux/virtio_gpu.h.s
+  CC      usr/include/linux/minix_fs.h.s
+  CC      usr/include/linux/if_ether.h.s
+  CC      usr/include/linux/if_pppox.h.s
+  CC      usr/include/linux/ip.h.s
+  CC      usr/include/linux/bsg.h.s
+  CC      usr/include/linux/if.h.s
+  CC      usr/include/linux/if_packet.h.s
+  CC      usr/include/linux/atalk.h.s
+  CC      usr/include/linux/i2o-dev.h.s
+  CC      usr/include/linux/mroute6.h.s
+  CC      usr/include/linux/nfs_fs.h.s
+  CC      usr/include/linux/timerfd.h.s
+  CC      usr/include/linux/vhost.h.s
+  CC      usr/include/linux/fcntl.h.s
+  CC      usr/include/linux/uio.h.s
+  CC      usr/include/linux/atmmpc.h.s
+  CC      usr/include/linux/binfmts.h.s
+  CC      usr/include/linux/ppp_defs.h.s
+  CC      usr/include/linux/blktrace_api.h.s
+  CC      usr/include/linux/ipv6.h.s
+  CC      usr/include/linux/sched.h.s
+  CC      usr/include/linux/stat.h.s
+  CC      usr/include/linux/if_fc.h.s
+  CC      usr/include/linux/utime.h.s
+  CC      usr/include/linux/lwtunnel.h.s
+  CC      usr/include/linux/types.h.s
+  CC      usr/include/linux/qemu_fw_cfg.h.s
+  CC      usr/include/linux/cyclades.h.s
+  CC      usr/include/linux/bcm933xx_hcs.h.s
+  CC      usr/include/linux/hidraw.h.s
+  CC      usr/include/linux/cramfs_fs.h.s
+  CC      usr/include/linux/nfs4.h.s
+  CC      usr/include/linux/apm_bios.h.s
+  CC      usr/include/linux/nbd.h.s
+  CC      usr/include/linux/fsi.h.s
+  CC      usr/include/linux/eventpoll.h.s
+  CC      usr/include/linux/ptrace.h.s
+  CC      usr/include/linux/vtpm_proxy.h.s
+  CC      usr/include/linux/genetlink.h.s
+  CC      usr/include/linux/if_addr.h.s
+  CC      usr/include/linux/mqueue.h.s
+  CC      usr/include/linux/i2c.h.s
+  CC      usr/include/linux/connector.h.s
+  CC      usr/include/linux/if_frad.h.s
+  CC      usr/include/linux/hdreg.h.s
+  CC      usr/include/linux/times.h.s
+  CC      usr/include/linux/uvcvideo.h.s
+  CC      usr/include/linux/v4l2-common.h.s
+  CC      usr/include/linux/virtio_iommu.h.s
+  CC      usr/include/linux/bpqether.h.s
+  CC      usr/include/linux/aio_abi.h.s
+  CC      usr/include/linux/prctl.h.s
+  CC      usr/include/linux/shm.h.s
+  CC      usr/include/linux/x25.h.s
+  CC      usr/include/linux/fpga-dfl.h.s
+  CC      usr/include/linux/rxrpc.h.s
+  CC      usr/include/linux/xilinx-v4l2-controls.h.s
+  CC      usr/include/linux/vfio.h.s
+  CC      usr/include/linux/random.h.s
+  CC      usr/include/linux/cdrom.h.s
+  CC      usr/include/linux/serial_core.h.s
+  CC      usr/include/linux/virtio_fs.h.s
+  CC      usr/include/linux/dlm_device.h.s
+  CC      usr/include/linux/phantom.h.s
+  CC      usr/include/linux/cciss_ioctl.h.s
+  CC      usr/include/linux/userio.h.s
+  CC      usr/include/linux/futex.h.s
+  CC      usr/include/linux/if_addrlabel.h.s
+  CC      usr/include/linux/raw.h.s
+  CC      usr/include/linux/if_x25.h.s
+  CC      usr/include/linux/usbdevice_fs.h.s
+  CC      usr/include/linux/cec.h.s
+  CC      usr/include/linux/netlink.h.s
+  CC      usr/include/linux/ipc.h.s
+  CC      usr/include/linux/if_xdp.h.s
+  CC      usr/include/linux/v4l2-controls.h.s
+  CC      usr/include/linux/atmbr2684.h.s
+  CC      usr/include/linux/vfio_ccw.h.s
+  CC      usr/include/linux/resource.h.s
+  CC      usr/include/linux/if_alg.h.s
+  CC      usr/include/linux/tipc_sockets_diag.h.s
+  CC      usr/include/linux/mei.h.s
+  CC      usr/include/linux/pktcdvd.h.s
+  CC      usr/include/linux/vmcore.h.s
+  CC      usr/include/linux/virtio_net.h.s
+  CC      usr/include/linux/atmarp.h.s
+  CC      usr/include/linux/can.h.s
+  CC      usr/include/linux/if_pppol2tp.h.s
+  CC      usr/include/linux/radeonfb.h.s
+  CC      usr/include/linux/virtio_input.h.s
+  CC      usr/include/linux/loop.h.s
+  CC      usr/include/linux/lp.h.s
+  CC      usr/include/linux/ipx.h.s
+  CC      usr/include/linux/gpio.h.s
+  CC      usr/include/linux/virtio_scsi.h.s
+  CC      usr/include/linux/netfilter_bridge.h.s
+  CC      usr/include/linux/if_bonding.h.s
+  CC      usr/include/linux/mic_common.h.s
+  CC      usr/include/linux/vhost_types.h.s
+  CC      usr/include/linux/ndctl.h.s
+  CC      usr/include/linux/aspeed-p2a-ctrl.h.s
+  CC      usr/include/linux/blkzoned.h.s
+  CC      usr/include/linux/dn.h.s
+  CC      usr/include/linux/timex.h.s
+  CC      usr/include/linux/wimax.h.s
+  CC      usr/include/linux/cciss_defs.h.s
+  CC      usr/include/linux/fsl_hypervisor.h.s
+  CC      usr/include/linux/joystick.h.s
+  CC      usr/include/linux/net.h.s
+  CC      usr/include/linux/screen_info.h.s
+  CC      usr/include/sound/hdsp.h.s
+  CC      usr/include/sound/hdspm.h.s
+  CC      usr/include/sound/skl-tplg-interface.h.s
+  CC      usr/include/sound/firewire.h.s
+  CC      usr/include/sound/compress_params.h.s
+  CC      usr/include/scsi/scsi_bsg_ufs.h.s
+  CC      usr/include/scsi/cxlflash_ioctl.h.s
+  CC      usr/include/scsi/scsi_netlink.h.s
+  CC      usr/include/scsi/scsi_netlink_fc.h.s
+  CC      usr/include/scsi/scsi_bsg_fc.h.s
+  CC      usr/include/rdma/hfi/hfi1_ioctl.h.s
+  CC      usr/include/rdma/hfi/hfi1_user.h.s
+  CC      usr/include/linux/wimax/i2400m.h.s
+  CC      usr/include/linux/can/netlink.h.s
+  CC      usr/include/linux/can/gw.h.s
+  CC      usr/include/linux/can/raw.h.s
+  CC      usr/include/linux/can/bcm.h.s
+  CC      usr/include/linux/can/j1939.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_mark_m.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_nat.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_nflog.h.s
+  CC      usr/include/linux/netfilter_bridge/ebtables.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_ip6.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_pkttype.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_among.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_arp.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_limit.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_stp.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_vlan.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_arpreply.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_log.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_802_3.h.s
+  CC      usr/include/linux/netfilter_bridge/ebt_ip.h.s
+  CC      usr/include/linux/netfilter/xt_SYNPROXY.h.s
+  CC      usr/include/linux/netfilter/xt_ipvs.h.s
+  CC      usr/include/linux/netfilter/xt_esp.h.s
+  CC      usr/include/linux/netfilter/xt_mac.h.s
+  CC      usr/include/linux/netfilter/xt_time.h.s
+  CC      usr/include/linux/netfilter/xt_cluster.h.s
+  CC      usr/include/linux/netfilter/xt_cpu.h.s
+  CC      usr/include/linux/netfilter/xt_connmark.h.s
+  CC      usr/include/linux/netfilter/nfnetlink_cttimeout.h.s
+  CC      usr/include/linux/netfilter/xt_CT.h.s
+  CC      usr/include/linux/netfilter/xt_addrtype.h.s
+  CC      usr/include/linux/netfilter/xt_SECMARK.h.s
+  CC      usr/include/linux/netfilter/xt_recent.h.s
+  CC      usr/include/linux/netfilter/xt_IDLETIMER.h.s
+  CC      usr/include/linux/netfilter/xt_dscp.h.s
+  CC      usr/include/linux/netfilter/xt_ecn.h.s
+  CC      usr/include/linux/netfilter/xt_NFLOG.h.s
+  CC      usr/include/linux/netfilter/xt_string.h.s
+  CC      usr/include/linux/netfilter/x_tables.h.s
+  CC      usr/include/linux/netfilter/xt_tcpmss.h.s
+  CC      usr/include/linux/netfilter/nf_conntrack_tuple_common.h.s
+  CC      usr/include/linux/netfilter/nf_nat.h.s
+  CC      usr/include/linux/netfilter/xt_DSCP.h.s
+  CC      usr/include/linux/netfilter/xt_policy.h.s
+  CC      usr/include/linux/netfilter/nfnetlink_queue.h.s
+  CC      usr/include/linux/netfilter/xt_realm.h.s
+  CC      usr/include/linux/netfilter/xt_physdev.h.s
+  CC      usr/include/linux/netfilter/nf_conntrack_sctp.h.s
+  CC      usr/include/linux/netfilter/xt_rpfilter.h.s
+  CC      usr/include/linux/netfilter/nfnetlink_conntrack.h.s
+  CC      usr/include/linux/netfilter/xt_AUDIT.h.s
+  CC      usr/include/linux/netfilter/xt_quota.h.s
+  CC      usr/include/linux/netfilter/xt_RATEEST.h.s
+  CC      usr/include/linux/netfilter/xt_LED.h.s
+  CC      usr/include/linux/netfilter/xt_HMARK.h.s
+  CC      usr/include/linux/netfilter/xt_CONNMARK.h.s
+  CC      usr/include/linux/netfilter/nfnetlink_compat.h.s
+  CC      usr/include/linux/netfilter/nfnetlink_osf.h.s
+  CC      usr/include/linux/netfilter/xt_TCPMSS.h.s
+  CC      usr/include/linux/netfilter/xt_CLASSIFY.h.s
+  CC      usr/include/linux/netfilter/xt_cgroup.h.s
+  CC      usr/include/linux/netfilter/xt_hashlimit.h.s
+  CC      usr/include/linux/netfilter/xt_mark.h.s
+  CC      usr/include/linux/netfilter/xt_conntrack.h.s
+  CC      usr/include/linux/netfilter/xt_devgroup.h.s
+  CC      usr/include/linux/netfilter/xt_ipcomp.h.s
+  CC      usr/include/linux/netfilter/xt_u32.h.s
+  CC      usr/include/linux/netfilter/xt_TPROXY.h.s
+  CC      usr/include/linux/netfilter/xt_connlabel.h.s
+  CC      usr/include/linux/netfilter/xt_iprange.h.s
+  CC      usr/include/linux/netfilter/xt_connbytes.h.s
+  CC      usr/include/linux/netfilter/xt_owner.h.s
+  CC      usr/include/linux/netfilter/nf_synproxy.h.s
+  CC      usr/include/linux/netfilter/xt_osf.h.s
+  CC      usr/include/linux/netfilter/xt_socket.h.s
+  CC      usr/include/linux/netfilter/nfnetlink.h.s
+  CC      usr/include/linux/netfilter/xt_NFQUEUE.h.s
+  CC      usr/include/linux/netfilter/xt_statistic.h.s
+  CC      usr/include/linux/netfilter/xt_rateest.h.s
+  CC      usr/include/linux/netfilter/xt_CONNSECMARK.h.s
+  CC      usr/include/linux/netfilter/xt_TEE.h.s
+  CC      usr/include/linux/netfilter/xt_l2tp.h.s
+  CC      usr/include/linux/netfilter/xt_CHECKSUM.h.s
+  CC      usr/include/linux/netfilter/xt_dccp.h.s
+  CC      usr/include/linux/netfilter/xt_limit.h.s
+  CC      usr/include/linux/netfilter/xt_bpf.h.s
+  CC      usr/include/linux/netfilter/xt_sctp.h.s
+  CC      usr/include/linux/netfilter/xt_set.h.s
+  CC      usr/include/linux/netfilter/xt_tcpudp.h.s
+  CC      usr/include/linux/netfilter/xt_multiport.h.s
+  CC      usr/include/linux/netfilter/xt_MARK.h.s
+  CC      usr/include/linux/netfilter/xt_length.h.s
+  CC      usr/include/linux/netfilter/nfnetlink_log.h.s
+  CC      usr/include/linux/netfilter/xt_TCPOPTSTRIP.h.s
+  CC      usr/include/linux/netfilter/xt_connlimit.h.s
+  CC      usr/include/linux/netfilter/nf_conntrack_tcp.h.s
+  CC      usr/include/linux/genwqe/genwqe_card.h.s
+  CC      usr/include/linux/iio/events.h.s
+  CC      usr/include/linux/caif/if_caif.h.s
+  CC      usr/include/linux/caif/caif_socket.h.s
+  CC      usr/include/linux/hsi/hsi_char.h.s
+  CC      usr/include/linux/hsi/cs-protocol.h.s
+  CC      usr/include/linux/netfilter_arp/arp_tables.h.s
+  CC      usr/include/linux/netfilter_arp/arpt_mangle.h.s
+  CC      usr/include/linux/mmc/ioctl.h.s
+  CC      usr/include/linux/spi/spidev.h.s
+  CC      usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h.s
+  CC      usr/include/linux/netfilter_ipv4/ipt_ECN.h.s
+  CC      usr/include/linux/netfilter_ipv4/ipt_ttl.h.s
+  CC      usr/include/linux/netfilter_ipv4/ipt_ecn.h.s
+  CC      usr/include/linux/netfilter_ipv4/ip_tables.h.s
+  CC      usr/include/linux/netfilter_ipv4/ipt_ah.h.s
+  CC      usr/include/linux/netfilter_ipv4/ipt_TTL.h.s
+  CC      usr/include/linux/usb/functionfs.h.s
+  CC      usr/include/linux/usb/ch9.h.s
+  CC      usr/include/linux/usb/g_uvc.h.s
+  CC      usr/include/linux/usb/tmc.h.s
+  CC      usr/include/linux/usb/cdc.h.s
+  CC      usr/include/linux/usb/cdc-wdm.h.s
+  CC      usr/include/linux/usb/gadgetfs.h.s
+  CC      usr/include/linux/usb/video.h.s
+  CC      usr/include/linux/usb/ch11.h.s
+  CC      usr/include/linux/usb/midi.h.s
+  CC      usr/include/linux/tc_act/tc_csum.h.s
+  CC      usr/include/linux/tc_act/tc_nat.h.s
+  CC      usr/include/linux/tc_act/tc_ct.h.s
+  CC      usr/include/linux/tc_act/tc_connmark.h.s
+  CC      usr/include/linux/tc_act/tc_skbedit.h.s
+  CC      usr/include/linux/tc_act/tc_mirred.h.s
+  CC      usr/include/linux/tc_act/tc_tunnel_key.h.s
+  CC      usr/include/linux/tc_act/tc_pedit.h.s
+  CC      usr/include/linux/tc_act/tc_mpls.h.s
+  CC      usr/include/linux/tc_act/tc_sample.h.s
+  CC      usr/include/linux/tc_act/tc_ctinfo.h.s
+  CC      usr/include/linux/tc_act/tc_bpf.h.s
+  CC      usr/include/linux/tc_act/tc_ipt.h.s
+  CC      usr/include/linux/tc_act/tc_skbmod.h.s
+  CC      usr/include/linux/tc_act/tc_defact.h.s
+  CC      usr/include/linux/tc_act/tc_vlan.h.s
+  CC      usr/include/linux/tc_act/tc_gact.h.s
+  CC      usr/include/linux/tc_act/tc_ife.h.s
+  CC      usr/include/linux/tc_ematch/tc_em_text.h.s
+  CC      usr/include/linux/tc_ematch/tc_em_cmp.h.s
+  CC      usr/include/linux/tc_ematch/tc_em_meta.h.s
+  CC      usr/include/linux/tc_ematch/tc_em_nbyte.h.s
+  CC      usr/include/linux/tc_ematch/tc_em_ipt.h.s
+  CC      usr/include/linux/nfsd/nfsfh.h.s
+  CC      usr/include/linux/nfsd/cld.h.s
+  CC      usr/include/linux/nfsd/stats.h.s
+  CC      usr/include/linux/nfsd/export.h.s
+  CC      usr/include/linux/netfilter_ipv6/ip6t_NPT.h.s
+  CC      usr/include/linux/netfilter_ipv6/ip6t_srh.h.s
+  CC      usr/include/linux/netfilter_ipv6/ip6t_ah.h.s
+  CC      usr/include/linux/netfilter_ipv6/ip6t_HL.h.s
+  CC      usr/include/linux/netfilter_ipv6/ip6t_mh.h.s
+  CC      usr/include/linux/netfilter_ipv6/ip6_tables.h.s
+  CC      usr/include/linux/netfilter_ipv6/ip6t_rt.h.s
+  CC      usr/include/linux/netfilter_ipv6/ip6t_opts.h.s
+  CC      usr/include/linux/netfilter_ipv6/ip6t_hl.h.s
+  CC      usr/include/linux/netfilter_ipv6/ip6t_frag.h.s
+  CC      usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h.s
+  CC      usr/include/linux/netfilter_ipv6/ip6t_REJECT.h.s
+  CC      usr/include/linux/dvb/dmx.h.s
+  CC      usr/include/linux/dvb/audio.h.s
+  CC      usr/include/linux/dvb/frontend.h.s
+  CC      usr/include/linux/dvb/net.h.s
+  CC      usr/include/linux/dvb/video.h.s
+  CC      usr/include/linux/raid/md_p.h.s
+  CC      usr/include/linux/sched/types.h.s
+  CC      usr/include/sound/sof/fw.h.s
+  CC      usr/include/sound/sof/header.h.s
+  CC      usr/include/scsi/fc/fc_fs.h.s
+  CC      usr/include/scsi/fc/fc_els.h.s
+  CC      usr/include/scsi/fc/fc_gs.h.s
+  CC      usr/include/scsi/fc/fc_ns.h.s
+  CC      usr/include/linux/netfilter/ipset/ip_set.h.s
+  CC      usr/include/linux/netfilter/ipset/ip_set_list.h.s
+  CC      usr/include/linux/netfilter/ipset/ip_set_hash.h.s
+  CC      usr/include/linux/netfilter/ipset/ip_set_bitmap.h.s
+  CHECK   arch/x86/crypto/glue_helper.c
+  CC [M]  arch/x86/crypto/glue_helper.o
+  CHECK   arch/x86/crypto/des3_ede_glue.c
+  CC [M]  arch/x86/crypto/des3_ede_glue.o
+  LD [M]  arch/x86/crypto/des3_ede-x86_64.o
+  CHECK   arch/x86/crypto/camellia_glue.c
+  CC [M]  arch/x86/crypto/camellia_glue.o
+  LD [M]  arch/x86/crypto/camellia-x86_64.o
+  CHECK   arch/x86/crypto/blowfish_glue.c
+  CC [M]  arch/x86/crypto/blowfish_glue.o
+  LD [M]  arch/x86/crypto/blowfish-x86_64.o
+  CHECK   arch/x86/crypto/twofish_glue.c
+  CC [M]  arch/x86/crypto/twofish_glue.o
+  LD [M]  arch/x86/crypto/twofish-x86_64.o
+  CHECK   arch/x86/crypto/twofish_glue_3way.c
+  CC [M]  arch/x86/crypto/twofish_glue_3way.o
+  LD [M]  arch/x86/crypto/twofish-x86_64-3way.o
+  CHECK   arch/x86/crypto/chacha_glue.c
+  CC [M]  arch/x86/crypto/chacha_glue.o
+  LD [M]  arch/x86/crypto/chacha-x86_64.o
+  CHECK   arch/x86/crypto/serpent_sse2_glue.c
+  CC [M]  arch/x86/crypto/serpent_sse2_glue.o
+  LD [M]  arch/x86/crypto/serpent-sse2-x86_64.o
+  CHECK   arch/x86/crypto/aesni-intel_glue.c
+  CC [M]  arch/x86/crypto/aesni-intel_glue.o
+  LD [M]  arch/x86/crypto/aesni-intel.o
+  CHECK   arch/x86/crypto/ghash-clmulni-intel_glue.c
+  CC [M]  arch/x86/crypto/ghash-clmulni-intel_glue.o
+  LD [M]  arch/x86/crypto/ghash-clmulni-intel.o
+  CHECK   arch/x86/crypto/crc32c-intel_glue.c
+  CC [M]  arch/x86/crypto/crc32c-intel_glue.o
+  LD [M]  arch/x86/crypto/crc32c-intel.o
+  CHECK   arch/x86/crypto/sha1_ssse3_glue.c
+  CC [M]  arch/x86/crypto/sha1_ssse3_glue.o
+  LD [M]  arch/x86/crypto/sha1-ssse3.o
+  CHECK   arch/x86/crypto/crc32-pclmul_glue.c
+  CC [M]  arch/x86/crypto/crc32-pclmul_glue.o
+  LD [M]  arch/x86/crypto/crc32-pclmul.o
+  CHECK   arch/x86/crypto/sha256_ssse3_glue.c
+  CC [M]  arch/x86/crypto/sha256_ssse3_glue.o
+  LD [M]  arch/x86/crypto/sha256-ssse3.o
+  CHECK   arch/x86/crypto/sha512_ssse3_glue.c
+  CC [M]  arch/x86/crypto/sha512_ssse3_glue.o
+  LD [M]  arch/x86/crypto/sha512-ssse3.o
+  CHECK   arch/x86/crypto/crct10dif-pclmul_glue.c
+  CC [M]  arch/x86/crypto/crct10dif-pclmul_glue.o
+  LD [M]  arch/x86/crypto/crct10dif-pclmul.o
+  CHECK   arch/x86/crypto/poly1305_glue.c
+  CC [M]  arch/x86/crypto/poly1305_glue.o
+  LD [M]  arch/x86/crypto/poly1305-x86_64.o
+  CHECK   arch/x86/crypto/aegis128-aesni-glue.c
+  CC [M]  arch/x86/crypto/aegis128-aesni-glue.o
+  LD [M]  arch/x86/crypto/aegis128-aesni.o
+  CHECK   arch/x86/crypto/nhpoly1305-sse2-glue.c
+  CC [M]  arch/x86/crypto/nhpoly1305-sse2-glue.o
+  LD [M]  arch/x86/crypto/nhpoly1305-sse2.o
+  CHECK   arch/x86/crypto/nhpoly1305-avx2-glue.c
+  CC [M]  arch/x86/crypto/nhpoly1305-avx2-glue.o
+  LD [M]  arch/x86/crypto/nhpoly1305-avx2.o
+  CHECK   arch/x86/crypto/camellia_aesni_avx_glue.c
+  CC [M]  arch/x86/crypto/camellia_aesni_avx_glue.o
+  LD [M]  arch/x86/crypto/camellia-aesni-avx-x86_64.o
+  CHECK   arch/x86/crypto/cast5_avx_glue.c
+  CC [M]  arch/x86/crypto/cast5_avx_glue.o
+  LD [M]  arch/x86/crypto/cast5-avx-x86_64.o
+  CHECK   arch/x86/crypto/cast6_avx_glue.c
+  CC [M]  arch/x86/crypto/cast6_avx_glue.o
+  LD [M]  arch/x86/crypto/cast6-avx-x86_64.o
+  CHECK   arch/x86/crypto/twofish_avx_glue.c
+  CC [M]  arch/x86/crypto/twofish_avx_glue.o
+  LD [M]  arch/x86/crypto/twofish-avx-x86_64.o
+  CHECK   arch/x86/crypto/serpent_avx_glue.c
+  CC [M]  arch/x86/crypto/serpent_avx_glue.o
+  LD [M]  arch/x86/crypto/serpent-avx-x86_64.o
+  CHECK   arch/x86/crypto/camellia_aesni_avx2_glue.c
+  CC [M]  arch/x86/crypto/camellia_aesni_avx2_glue.o
+  LD [M]  arch/x86/crypto/camellia-aesni-avx2.o
+  CHECK   arch/x86/crypto/serpent_avx2_glue.c
+  CC [M]  arch/x86/crypto/serpent_avx2_glue.o
+  LD [M]  arch/x86/crypto/serpent-avx2.o
+  AS      arch/x86/entry/entry_64.o
+  AS      arch/x86/entry/thunk_64.o
+  CHECK   arch/x86/entry/syscall_64.c
+  CC      arch/x86/entry/syscall_64.o
+  CHECK   arch/x86/entry/common.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC      arch/x86/entry/common.o
+  CHECK   arch/x86/entry/vdso/vma.c
+  CC      arch/x86/entry/vdso/vma.o
+  CHECK   arch/x86/entry/vdso/vdso32-setup.c
+arch/x86/entry/vdso/vdso32-setup.c:28:28: warning: symbol 'vdso32_enabled' was not declared. Should it be static?
+  CC      arch/x86/entry/vdso/vdso32-setup.o
+  LDS     arch/x86/entry/vdso/vdso.lds
+  CHECK   arch/x86/entry/vdso/vclock_gettime.c
+arch/x86/entry/vdso/../../../../lib/vdso/gettimeofday.c:224:5: warning: symbol '__cvdso_clock_getres' was not declared. Should it be static?
+  CC      arch/x86/entry/vdso/vclock_gettime.o
+  CHECK   arch/x86/entry/vdso/vgetcpu.c
+arch/x86/entry/vdso/vgetcpu.c:14:1: warning: symbol '__vdso_getcpu' was not declared. Should it be static?
+  CC      arch/x86/entry/vdso/vgetcpu.o
+  VDSO    arch/x86/entry/vdso/vdso64.so.dbg
+  OBJCOPY arch/x86/entry/vdso/vdso64.so
+  HOSTCC  arch/x86/entry/vdso/vdso2c
+  VDSO2C  arch/x86/entry/vdso/vdso-image-64.c
+  CHECK   arch/x86/entry/vdso/vdso-image-64.c
+  CC      arch/x86/entry/vdso/vdso-image-64.o
+  LDS     arch/x86/entry/vdso/vdsox32.lds
+  X32     arch/x86/entry/vdso/vclock_gettime-x32.o
+  X32     arch/x86/entry/vdso/vgetcpu-x32.o
+  VDSO    arch/x86/entry/vdso/vdsox32.so.dbg
+  OBJCOPY arch/x86/entry/vdso/vdsox32.so
+  VDSO2C  arch/x86/entry/vdso/vdso-image-x32.c
+  CHECK   arch/x86/entry/vdso/vdso-image-x32.c
+  CC      arch/x86/entry/vdso/vdso-image-x32.o
+  LDS     arch/x86/entry/vdso/vdso32/vdso32.lds
+  CHECK   arch/x86/entry/vdso/vdso32/vclock_gettime.c
+arch/x86/entry/vdso/vdso32/../../../../../lib/vdso/gettimeofday.c:224:5: warning: symbol '__cvdso_clock_getres' was not declared. Should it be static?
+arch/x86/entry/vdso/vdso32/../vclock_gettime.c:70:5: warning: symbol '__vdso_clock_gettime64' was not declared. Should it be static?
+  CC      arch/x86/entry/vdso/vdso32/vclock_gettime.o
+  VDSO    arch/x86/entry/vdso/vdso32.so.dbg
+  OBJCOPY arch/x86/entry/vdso/vdso32.so
+  VDSO2C  arch/x86/entry/vdso/vdso-image-32.c
+  CHECK   arch/x86/entry/vdso/vdso-image-32.c
+  CC      arch/x86/entry/vdso/vdso-image-32.o
+  AR      arch/x86/entry/vdso/built-in.a
+  CHECK   arch/x86/entry/vsyscall/vsyscall_64.c
+  CC      arch/x86/entry/vsyscall/vsyscall_64.o
+  AS      arch/x86/entry/vsyscall/vsyscall_emu_64.o
+  AR      arch/x86/entry/vsyscall/built-in.a
+  AS      arch/x86/entry/entry_64_compat.o
+  CHECK   arch/x86/entry/syscall_32.c
+  CC      arch/x86/entry/syscall_32.o
+  AR      arch/x86/entry/built-in.a
+  CHECK   arch/x86/events/core.c
+arch/x86/events/core.c:2313:6: warning: symbol 'arch_perf_update_userpage' was not declared. Should it be static?
+  CC      arch/x86/events/core.o
+  CHECK   arch/x86/events/probe.c
+  CC      arch/x86/events/probe.o
+  CHECK   arch/x86/events/amd/core.c
+  CC      arch/x86/events/amd/core.o
+  CHECK   arch/x86/events/amd/uncore.c
+  CC      arch/x86/events/amd/uncore.o
+  CHECK   arch/x86/events/amd/ibs.c
+  CC      arch/x86/events/amd/ibs.o
+  CHECK   arch/x86/events/amd/iommu.c
+  CC      arch/x86/events/amd/iommu.o
+  AR      arch/x86/events/amd/built-in.a
+  CHECK   arch/x86/events/amd/power.c
+  CC [M]  arch/x86/events/amd/power.o
+  CHECK   arch/x86/events/intel/core.c
+arch/x86/events/intel/core.c:2804:1: warning: context imbalance in 'intel_start_scheduling' - different lock contexts for basic block
+arch/x86/events/intel/core.c:2877:9: warning: context imbalance in 'intel_stop_scheduling' - unexpected unlock
+arch/x86/events/intel/core.c:3083:25: warning: context imbalance in 'intel_put_excl_constraints' - unexpected unlock
+  CC      arch/x86/events/intel/core.o
+  CHECK   arch/x86/events/intel/bts.c
+  CC      arch/x86/events/intel/bts.o
+  CHECK   arch/x86/events/intel/ds.c
+  CC      arch/x86/events/intel/ds.o
+  CHECK   arch/x86/events/intel/knc.c
+  CC      arch/x86/events/intel/knc.o
+  CHECK   arch/x86/events/intel/lbr.c
+  CC      arch/x86/events/intel/lbr.o
+  CHECK   arch/x86/events/intel/p4.c
+  CC      arch/x86/events/intel/p4.o
+  CHECK   arch/x86/events/intel/p6.c
+  CC      arch/x86/events/intel/p6.o
+  CHECK   arch/x86/events/intel/pt.c
+  CC      arch/x86/events/intel/pt.o
+  AR      arch/x86/events/intel/built-in.a
+  CHECK   arch/x86/events/intel/rapl.c
+  CC [M]  arch/x86/events/intel/rapl.o
+  LD [M]  arch/x86/events/intel/intel-rapl-perf.o
+  CHECK   arch/x86/events/intel/uncore.c
+  CC [M]  arch/x86/events/intel/uncore.o
+  CHECK   arch/x86/events/intel/uncore_nhmex.c
+./arch/x86/include/asm/paravirt.h:200:9: warning: cast truncates bits from constant value (8000000000000000 becomes 0)
+./arch/x86/include/asm/paravirt.h:200:9: warning: cast truncates bits from constant value (8000000000000000 becomes 0)
+  CC [M]  arch/x86/events/intel/uncore_nhmex.o
+  CHECK   arch/x86/events/intel/uncore_snb.c
+./arch/x86/include/asm/paravirt.h:200:9: warning: cast truncates bits from constant value (1000000ff becomes ff)
+  CC [M]  arch/x86/events/intel/uncore_snb.o
+  CHECK   arch/x86/events/intel/uncore_snbep.c
+  CC [M]  arch/x86/events/intel/uncore_snbep.o
+  LD [M]  arch/x86/events/intel/intel-uncore.o
+  CHECK   arch/x86/events/intel/cstate.c
+  CC [M]  arch/x86/events/intel/cstate.o
+  LD [M]  arch/x86/events/intel/intel-cstate.o
+  CHECK   arch/x86/events/msr.c
+  CC      arch/x86/events/msr.o
+  AR      arch/x86/events/built-in.a
+  CHECK   arch/x86/hyperv/hv_init.c
+arch/x86/hyperv/hv_init.c:61:30: warning: incorrect type in initializer (different address spaces)
+arch/x86/hyperv/hv_init.c:61:30:    expected void const [noderef] <asn:3> *__vpp_verify
+arch/x86/hyperv/hv_init.c:61:30:    got void [noderef] <asn:3> **
+arch/x86/hyperv/hv_init.c:200:30: warning: incorrect type in initializer (different address spaces)
+arch/x86/hyperv/hv_init.c:200:30:    expected void const [noderef] <asn:3> *__vpp_verify
+arch/x86/hyperv/hv_init.c:200:30:    got void [noderef] <asn:3> **
+arch/x86/hyperv/hv_init.c:270:31: warning: incorrect type in assignment (different address spaces)
+arch/x86/hyperv/hv_init.c:270:31:    expected void [noderef] <asn:3> **extern [addressable] [toplevel] hyperv_pcpu_input_arg
+arch/x86/hyperv/hv_init.c:270:31:    got void *[noderef] <asn:3> *
+./arch/x86/include/asm/paravirt.h:200:9: warning: cast truncates bits from constant value (8000000000000000 becomes 0)
+./arch/x86/include/asm/paravirt.h:200:9: warning: cast truncates bits from constant value (c000000000000000 becomes 0)
+  CC      arch/x86/hyperv/hv_init.o
+  CHECK   arch/x86/hyperv/mmu.c
+arch/x86/hyperv/mmu.c:176:22: warning: incorrect type in initializer (different address spaces)
+arch/x86/hyperv/mmu.c:176:22:    expected void const [noderef] <asn:3> *__vpp_verify
+arch/x86/hyperv/mmu.c:176:22:    got void [noderef] <asn:3> **
+arch/x86/hyperv/mmu.c:75:22: warning: incorrect type in initializer (different address spaces)
+arch/x86/hyperv/mmu.c:75:22:    expected void const [noderef] <asn:3> *__vpp_verify
+arch/x86/hyperv/mmu.c:75:22:    got void [noderef] <asn:3> **
+  CC      arch/x86/hyperv/mmu.o
+  CHECK   arch/x86/hyperv/nested.c
+arch/x86/hyperv/nested.c:34:17: warning: incorrect type in initializer (different address spaces)
+arch/x86/hyperv/nested.c:34:17:    expected void const [noderef] <asn:3> *__vpp_verify
+arch/x86/hyperv/nested.c:34:17:    got void [noderef] <asn:3> **
+arch/x86/hyperv/nested.c:106:17: warning: incorrect type in initializer (different address spaces)
+arch/x86/hyperv/nested.c:106:17:    expected void const [noderef] <asn:3> *__vpp_verify
+arch/x86/hyperv/nested.c:106:17:    got void [noderef] <asn:3> **
+  CC      arch/x86/hyperv/nested.o
+  CHECK   arch/x86/hyperv/hv_apic.c
+arch/x86/hyperv/hv_apic.c:112:41: warning: incorrect type in initializer (different address spaces)
+arch/x86/hyperv/hv_apic.c:112:41:    expected void const [noderef] <asn:3> *__vpp_verify
+arch/x86/hyperv/hv_apic.c:112:41:    got void [noderef] <asn:3> **
+  CC      arch/x86/hyperv/hv_apic.o
+  CHECK   arch/x86/hyperv/hv_spinlock.c
+  CC      arch/x86/hyperv/hv_spinlock.o
+  AR      arch/x86/hyperv/built-in.a
+  CHECK   arch/x86/ia32/sys_ia32.c
+  CC      arch/x86/ia32/sys_ia32.o
+  CHECK   arch/x86/ia32/ia32_signal.c
+  CC      arch/x86/ia32/ia32_signal.o
+  CHECK   arch/x86/ia32/audit.c
+arch/x86/ia32/audit.c:4:10: warning: symbol 'ia32_dir_class' was not declared. Should it be static?
+arch/x86/ia32/audit.c:9:10: warning: symbol 'ia32_chattr_class' was not declared. Should it be static?
+arch/x86/ia32/audit.c:14:10: warning: symbol 'ia32_write_class' was not declared. Should it be static?
+arch/x86/ia32/audit.c:19:10: warning: symbol 'ia32_read_class' was not declared. Should it be static?
+arch/x86/ia32/audit.c:24:10: warning: symbol 'ia32_signal_class' was not declared. Should it be static?
+arch/x86/ia32/audit.c:29:5: warning: symbol 'ia32_classify_syscall' was not declared. Should it be static?
+  CC      arch/x86/ia32/audit.o
+  AR      arch/x86/ia32/built-in.a
+  CHECK   arch/x86/kernel/process_64.c
+  CC      arch/x86/kernel/process_64.o
+  CHECK   arch/x86/kernel/signal.c
+  CC      arch/x86/kernel/signal.o
+  CHECK   arch/x86/kernel/signal_compat.c
+  CC      arch/x86/kernel/signal_compat.o
+  CHECK   arch/x86/kernel/traps.c
+  CC      arch/x86/kernel/traps.o
+  CHECK   arch/x86/kernel/idt.c
+  CC      arch/x86/kernel/idt.o
+  CHECK   arch/x86/kernel/irq.c
+  CC      arch/x86/kernel/irq.o
+  CHECK   arch/x86/kernel/irq_64.c
+arch/x86/kernel/irq_64.c:26:1: warning: symbol '__pcpu_scope_irq_stack_backing_store' was not declared. Should it be static?
+  CC      arch/x86/kernel/irq_64.o
+  CHECK   arch/x86/kernel/dumpstack_64.c
+  CC      arch/x86/kernel/dumpstack_64.o
+  CHECK   arch/x86/kernel/time.c
+  CC      arch/x86/kernel/time.o
+  CHECK   arch/x86/kernel/ioport.c
+arch/x86/kernel/ioport.c:64:6: warning: symbol 'ksys_ioperm' was not declared. Should it be static?
+  CC      arch/x86/kernel/ioport.o
+  CHECK   arch/x86/kernel/dumpstack.c
+  CC      arch/x86/kernel/dumpstack.o
+  CHECK   arch/x86/kernel/nmi.c
+  CC      arch/x86/kernel/nmi.o
+  CHECK   arch/x86/kernel/ldt.c
+./arch/x86/include/asm/paravirt.h:365:23: warning: context imbalance in 'unmap_ldt_struct' - different lock contexts for basic block
+  CC      arch/x86/kernel/ldt.o
+  CHECK   arch/x86/kernel/setup.c
+  CC      arch/x86/kernel/setup.o
+  CHECK   arch/x86/kernel/x86_init.c
+  CC      arch/x86/kernel/x86_init.o
+  CHECK   arch/x86/kernel/i8259.c
+arch/x86/kernel/i8259.c:410:19: warning: symbol 'default_legacy_pic' was not declared. Should it be static?
+  CC      arch/x86/kernel/i8259.o
+  CHECK   arch/x86/kernel/irqinit.c
+  CC      arch/x86/kernel/irqinit.o
+  CHECK   arch/x86/kernel/jump_label.c
+  CC      arch/x86/kernel/jump_label.o
+  CHECK   arch/x86/kernel/irq_work.c
+  CC      arch/x86/kernel/irq_work.o
+  CHECK   arch/x86/kernel/probe_roms.c
+  CC      arch/x86/kernel/probe_roms.o
+  CHECK   arch/x86/kernel/sys_x86_64.c
+  CC      arch/x86/kernel/sys_x86_64.o
+  CHECK   arch/x86/kernel/espfix_64.c
+  CC      arch/x86/kernel/espfix_64.o
+  CHECK   arch/x86/kernel/ksysfs.c
+  CC      arch/x86/kernel/ksysfs.o
+  CHECK   arch/x86/kernel/bootflag.c
+  CC      arch/x86/kernel/bootflag.o
+  CHECK   arch/x86/kernel/e820.c
+  CC      arch/x86/kernel/e820.o
+  CHECK   arch/x86/kernel/pci-dma.c
+  CC      arch/x86/kernel/pci-dma.o
+  CHECK   arch/x86/kernel/quirks.c
+arch/x86/kernel/quirks.c:666:6: warning: symbol 'x86_apple_machine' was not declared. Should it be static?
+  CC      arch/x86/kernel/quirks.o
+  CHECK   arch/x86/kernel/topology.c
+  CC      arch/x86/kernel/topology.o
+  CHECK   arch/x86/kernel/kdebugfs.c
+  CC      arch/x86/kernel/kdebugfs.o
+  CHECK   arch/x86/kernel/alternative.c
+arch/x86/kernel/alternative.c:838:15: warning: context imbalance in '__text_poke' - different lock contexts for basic block
+  CC      arch/x86/kernel/alternative.o
+  CHECK   arch/x86/kernel/i8253.c
+  CC      arch/x86/kernel/i8253.o
+  CHECK   arch/x86/kernel/hw_breakpoint.c
+  CC      arch/x86/kernel/hw_breakpoint.o
+  CHECK   arch/x86/kernel/tsc.c
+arch/x86/kernel/tsc.c:52:20: warning: symbol 'art_related_clocksource' was not declared. Should it be static?
+  CC      arch/x86/kernel/tsc.o
+  CHECK   arch/x86/kernel/tsc_msr.c
+  CC      arch/x86/kernel/tsc_msr.o
+  CHECK   arch/x86/kernel/io_delay.c
+  CC      arch/x86/kernel/io_delay.o
+  CHECK   arch/x86/kernel/rtc.c
+  CC      arch/x86/kernel/rtc.o
+  CHECK   arch/x86/kernel/pci-iommu_table.c
+  CC      arch/x86/kernel/pci-iommu_table.o
+  CHECK   arch/x86/kernel/resource.c
+  CC      arch/x86/kernel/resource.o
+  AS      arch/x86/kernel/irqflags.o
+  CHECK   arch/x86/kernel/process.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC      arch/x86/kernel/process.o
+  CHECK   arch/x86/kernel/acpi/boot.c
+arch/x86/kernel/acpi/boot.c:111:30: warning: incorrect type in return expression (different address spaces)
+arch/x86/kernel/acpi/boot.c:111:30:    expected void [noderef] <asn:2> *
+arch/x86/kernel/acpi/boot.c:111:30:    got void *
+arch/x86/kernel/acpi/boot.c:119:24: warning: incorrect type in argument 1 (different address spaces)
+arch/x86/kernel/acpi/boot.c:119:24:    expected void *addr
+arch/x86/kernel/acpi/boot.c:119:24:    got void [noderef] <asn:2> *map
+  CC      arch/x86/kernel/acpi/boot.o
+  CHECK   arch/x86/kernel/acpi/sleep.c
+  CC      arch/x86/kernel/acpi/sleep.o
+  AS      arch/x86/kernel/acpi/wakeup_64.o
+  CHECK   arch/x86/kernel/acpi/apei.c
+  CC      arch/x86/kernel/acpi/apei.o
+  CHECK   arch/x86/kernel/acpi/cppc_msr.c
+arch/x86/kernel/acpi/cppc_msr.c:21:42: warning: dereference of noderef expression
+arch/x86/kernel/acpi/cppc_msr.c:37:42: warning: dereference of noderef expression
+arch/x86/kernel/acpi/cppc_msr.c:46:50: warning: dereference of noderef expression
+  CC      arch/x86/kernel/acpi/cppc_msr.o
+  CHECK   arch/x86/kernel/acpi/cstate.c
+  CC      arch/x86/kernel/acpi/cstate.o
+  AR      arch/x86/kernel/acpi/built-in.a
+  CHECK   arch/x86/kernel/apic/apic.c
+  CC      arch/x86/kernel/apic/apic.o
+  CHECK   arch/x86/kernel/apic/apic_common.c
+  CC      arch/x86/kernel/apic/apic_common.o
+  CHECK   arch/x86/kernel/apic/apic_noop.c
+  CC      arch/x86/kernel/apic/apic_noop.o
+  CHECK   arch/x86/kernel/apic/ipi.c
+  CC      arch/x86/kernel/apic/ipi.o
+  CHECK   arch/x86/kernel/apic/vector.c
+arch/x86/kernel/apic/vector.c:50:6: warning: context imbalance in 'lock_vector_lock' - wrong count at exit
+arch/x86/kernel/apic/vector.c:58:6: warning: context imbalance in 'unlock_vector_lock' - unexpected unlock
+  CC      arch/x86/kernel/apic/vector.o
+  CHECK   arch/x86/kernel/apic/hw_nmi.c
+  CC      arch/x86/kernel/apic/hw_nmi.o
+  CHECK   arch/x86/kernel/apic/io_apic.c
+arch/x86/kernel/apic/io_apic.c:288:55: warning: incorrect type in initializer (different modifiers)
+arch/x86/kernel/apic/io_apic.c:288:55:    expected struct io_apic [noderef] <asn:2> *io_apic
+arch/x86/kernel/apic/io_apic.c:288:55:    got struct io_apic [noderef] [pure] <asn:2> *
+arch/x86/kernel/apic/io_apic.c:296:55: warning: incorrect type in initializer (different modifiers)
+arch/x86/kernel/apic/io_apic.c:296:55:    expected struct io_apic [noderef] <asn:2> *io_apic
+arch/x86/kernel/apic/io_apic.c:296:55:    got struct io_apic [noderef] [pure] <asn:2> *
+arch/x86/kernel/apic/io_apic.c:465:17: warning: incorrect type in assignment (different modifiers)
+arch/x86/kernel/apic/io_apic.c:465:17:    expected struct io_apic [noderef] <asn:2> *io_apic
+arch/x86/kernel/apic/io_apic.c:465:17:    got struct io_apic [noderef] [pure] <asn:2> *
+arch/x86/kernel/apic/io_apic.c:282:55: warning: incorrect type in initializer (different modifiers)
+arch/x86/kernel/apic/io_apic.c:282:55:    expected struct io_apic [noderef] <asn:2> *io_apic
+arch/x86/kernel/apic/io_apic.c:282:55:    got struct io_apic [noderef] [pure] <asn:2> *
+  CC      arch/x86/kernel/apic/io_apic.o
+  CHECK   arch/x86/kernel/apic/msi.c
+  CC      arch/x86/kernel/apic/msi.o
+  CHECK   arch/x86/kernel/apic/apic_numachip.c
+./arch/x86/include/asm/numachip/numachip_csr.h:52:41: warning: incorrect type in argument 2 (different address spaces)
+./arch/x86/include/asm/numachip/numachip_csr.h:52:41:    expected void volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/numachip/numachip_csr.h:52:41:    got void *
+  CC      arch/x86/kernel/apic/apic_numachip.o
+  CHECK   arch/x86/kernel/apic/x2apic_uv_x.c
+arch/x86/kernel/apic/x2apic_uv_x.c:420:12: warning: function 'uv_hub_info_version' with external linkage has definition
+arch/x86/kernel/apic/x2apic_uv_x.c:51:5: warning: symbol 'uv_min_hub_revision_id' was not declared. Should it be static?
+arch/x86/kernel/apic/x2apic_uv_x.c:79:13: warning: incorrect type in assignment (different address spaces)
+arch/x86/kernel/apic/x2apic_uv_x.c:79:13:    expected unsigned long *mmr
+arch/x86/kernel/apic/x2apic_uv_x.c:79:13:    got void [noderef] <asn:2> *
+arch/x86/kernel/apic/x2apic_uv_x.c:81:23: warning: incorrect type in argument 1 (different address spaces)
+arch/x86/kernel/apic/x2apic_uv_x.c:81:23:    expected void [noderef] <asn:2> *addr
+arch/x86/kernel/apic/x2apic_uv_x.c:81:23:    got unsigned long *mmr
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:681:41: warning: incorrect type in argument 2 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:681:41:    expected void volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:681:41:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+  CC      arch/x86/kernel/apic/x2apic_uv_x.o
+  CHECK   arch/x86/kernel/apic/x2apic_phys.c
+  CC      arch/x86/kernel/apic/x2apic_phys.o
+  CHECK   arch/x86/kernel/apic/x2apic_cluster.c
+  CC      arch/x86/kernel/apic/x2apic_cluster.o
+  CHECK   arch/x86/kernel/apic/apic_flat_64.c
+  CC      arch/x86/kernel/apic/apic_flat_64.o
+  CHECK   arch/x86/kernel/apic/probe_64.c
+  CC      arch/x86/kernel/apic/probe_64.o
+  AR      arch/x86/kernel/apic/built-in.a
+  CHECK   arch/x86/kernel/cpu/cacheinfo.c
+  CC      arch/x86/kernel/cpu/cacheinfo.o
+  CHECK   arch/x86/kernel/cpu/scattered.c
+  CC      arch/x86/kernel/cpu/scattered.o
+  CHECK   arch/x86/kernel/cpu/topology.c
+  CC      arch/x86/kernel/cpu/topology.o
+  CHECK   arch/x86/kernel/cpu/common.c
+arch/x86/kernel/cpu/common.c:1969:6: warning: symbol 'arch_smt_update' was not declared. Should it be static?
+arch/x86/kernel/cpu/common.c:121:43: warning: cast truncates bits from constant value (fffff becomes ffff)
+arch/x86/kernel/cpu/common.c:122:43: warning: cast truncates bits from constant value (fffff becomes ffff)
+arch/x86/kernel/cpu/common.c:123:43: warning: cast truncates bits from constant value (fffff becomes ffff)
+arch/x86/kernel/cpu/common.c:124:43: warning: cast truncates bits from constant value (fffff becomes ffff)
+arch/x86/kernel/cpu/common.c:125:43: warning: cast truncates bits from constant value (fffff becomes ffff)
+arch/x86/kernel/cpu/common.c:126:43: warning: cast truncates bits from constant value (fffff becomes ffff)
+  CC      arch/x86/kernel/cpu/common.o
+  CHECK   arch/x86/kernel/cpu/rdrand.c
+  CC      arch/x86/kernel/cpu/rdrand.o
+  CHECK   arch/x86/kernel/cpu/match.c
+  CC      arch/x86/kernel/cpu/match.o
+  CHECK   arch/x86/kernel/cpu/bugs.c
+arch/x86/kernel/cpu/bugs.c:1282:6: warning: symbol 'itlb_multihit_kvm_mitigation' was not declared. Should it be static?
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC      arch/x86/kernel/cpu/bugs.o
+  CHECK   arch/x86/kernel/cpu/aperfmperf.c
+  CC      arch/x86/kernel/cpu/aperfmperf.o
+  CHECK   arch/x86/kernel/cpu/cpuid-deps.c
+  CC      arch/x86/kernel/cpu/cpuid-deps.o
+  CHECK   arch/x86/kernel/cpu/umwait.c
+arch/x86/kernel/cpu/umwait.c:20:5: warning: symbol 'get_umwait_control_msr' was not declared. Should it be static?
+  CC      arch/x86/kernel/cpu/umwait.o
+  CHECK   arch/x86/kernel/cpu/proc.c
+  CC      arch/x86/kernel/cpu/proc.o
+  CHECK   arch/x86/kernel/cpu/capflags.c
+arch/x86/kernel/cpu/capflags.c:5:12: warning: symbol 'x86_cap_flags' was not declared. Should it be static?
+arch/x86/kernel/cpu/capflags.c:261:12: warning: symbol 'x86_bug_flags' was not declared. Should it be static?
+  CC      arch/x86/kernel/cpu/capflags.o
+  CHECK   arch/x86/kernel/cpu/powerflags.c
+  CC      arch/x86/kernel/cpu/powerflags.o
+  CHECK   arch/x86/kernel/cpu/intel.c
+  CC      arch/x86/kernel/cpu/intel.o
+  CHECK   arch/x86/kernel/cpu/intel_pconfig.c
+  CC      arch/x86/kernel/cpu/intel_pconfig.o
+  CHECK   arch/x86/kernel/cpu/tsx.c
+  CC      arch/x86/kernel/cpu/tsx.o
+  CHECK   arch/x86/kernel/cpu/intel_epb.c
+  CC      arch/x86/kernel/cpu/intel_epb.o
+  CHECK   arch/x86/kernel/cpu/amd.c
+  CC      arch/x86/kernel/cpu/amd.o
+  CHECK   arch/x86/kernel/cpu/hygon.c
+  CC      arch/x86/kernel/cpu/hygon.o
+  CHECK   arch/x86/kernel/cpu/centaur.c
+  CC      arch/x86/kernel/cpu/centaur.o
+  CHECK   arch/x86/kernel/cpu/zhaoxin.c
+  CC      arch/x86/kernel/cpu/zhaoxin.o
+  CHECK   arch/x86/kernel/cpu/mce/core.c
+  CC      arch/x86/kernel/cpu/mce/core.o
+  CHECK   arch/x86/kernel/cpu/mce/severity.c
+  CC      arch/x86/kernel/cpu/mce/severity.o
+  CHECK   arch/x86/kernel/cpu/mce/genpool.c
+  CC      arch/x86/kernel/cpu/mce/genpool.o
+  CHECK   arch/x86/kernel/cpu/mce/intel.c
+  CC      arch/x86/kernel/cpu/mce/intel.o
+  CHECK   arch/x86/kernel/cpu/mce/amd.c
+  CC      arch/x86/kernel/cpu/mce/amd.o
+  CHECK   arch/x86/kernel/cpu/mce/threshold.c
+  CC      arch/x86/kernel/cpu/mce/threshold.o
+  CHECK   arch/x86/kernel/cpu/mce/therm_throt.c
+  CC      arch/x86/kernel/cpu/mce/therm_throt.o
+  CHECK   arch/x86/kernel/cpu/mce/apei.c
+  CC      arch/x86/kernel/cpu/mce/apei.o
+  CHECK   arch/x86/kernel/cpu/mce/dev-mcelog.c
+  CC      arch/x86/kernel/cpu/mce/dev-mcelog.o
+  AR      arch/x86/kernel/cpu/mce/built-in.a
+  CHECK   arch/x86/kernel/cpu/mce/inject.c
+  CC [M]  arch/x86/kernel/cpu/mce/inject.o
+  LD [M]  arch/x86/kernel/cpu/mce/mce-inject.o
+  CHECK   arch/x86/kernel/cpu/microcode/core.c
+  CC      arch/x86/kernel/cpu/microcode/core.o
+  CHECK   arch/x86/kernel/cpu/microcode/intel.c
+  CC      arch/x86/kernel/cpu/microcode/intel.o
+  CHECK   arch/x86/kernel/cpu/microcode/amd.c
+arch/x86/kernel/cpu/microcode/amd.c:421:35: warning: Using plain integer as NULL pointer
+arch/x86/kernel/cpu/microcode/amd.c:546:35: warning: Using plain integer as NULL pointer
+  CC      arch/x86/kernel/cpu/microcode/amd.o
+  AR      arch/x86/kernel/cpu/microcode/built-in.a
+  CHECK   arch/x86/kernel/cpu/mtrr/mtrr.c
+  CC      arch/x86/kernel/cpu/mtrr/mtrr.o
+  CHECK   arch/x86/kernel/cpu/mtrr/if.c
+  CC      arch/x86/kernel/cpu/mtrr/if.o
+  CHECK   arch/x86/kernel/cpu/mtrr/generic.c
+  CC      arch/x86/kernel/cpu/mtrr/generic.o
+  CHECK   arch/x86/kernel/cpu/mtrr/cleanup.c
+  CC      arch/x86/kernel/cpu/mtrr/cleanup.o
+  AR      arch/x86/kernel/cpu/mtrr/built-in.a
+  CHECK   arch/x86/kernel/cpu/resctrl/core.c
+  CC      arch/x86/kernel/cpu/resctrl/core.o
+  CHECK   arch/x86/kernel/cpu/resctrl/rdtgroup.c
+  CC      arch/x86/kernel/cpu/resctrl/rdtgroup.o
+  CHECK   arch/x86/kernel/cpu/resctrl/monitor.c
+  CC      arch/x86/kernel/cpu/resctrl/monitor.o
+  CHECK   arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+  CC      arch/x86/kernel/cpu/resctrl/ctrlmondata.o
+  CHECK   arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+  CC      arch/x86/kernel/cpu/resctrl/pseudo_lock.o
+  AR      arch/x86/kernel/cpu/resctrl/built-in.a
+  CHECK   arch/x86/kernel/cpu/perfctr-watchdog.c
+  CC      arch/x86/kernel/cpu/perfctr-watchdog.o
+  CHECK   arch/x86/kernel/cpu/vmware.c
+  CC      arch/x86/kernel/cpu/vmware.o
+  CHECK   arch/x86/kernel/cpu/hypervisor.c
+  CC      arch/x86/kernel/cpu/hypervisor.o
+  CHECK   arch/x86/kernel/cpu/mshyperv.c
+  CC      arch/x86/kernel/cpu/mshyperv.o
+  CHECK   arch/x86/kernel/cpu/acrn.c
+  CC      arch/x86/kernel/cpu/acrn.o
+  AR      arch/x86/kernel/cpu/built-in.a
+  CHECK   arch/x86/kernel/fpu/init.c
+  CC      arch/x86/kernel/fpu/init.o
+  CHECK   arch/x86/kernel/fpu/bugs.c
+  CC      arch/x86/kernel/fpu/bugs.o
+  CHECK   arch/x86/kernel/fpu/core.c
+  CC      arch/x86/kernel/fpu/core.o
+  CHECK   arch/x86/kernel/fpu/regset.c
+  CC      arch/x86/kernel/fpu/regset.o
+  CHECK   arch/x86/kernel/fpu/signal.c
+  CC      arch/x86/kernel/fpu/signal.o
+  CHECK   arch/x86/kernel/fpu/xstate.c
+  CC      arch/x86/kernel/fpu/xstate.o
+  AR      arch/x86/kernel/fpu/built-in.a
+  CHECK   arch/x86/kernel/kprobes/core.c
+  CC      arch/x86/kernel/kprobes/core.o
+  CHECK   arch/x86/kernel/kprobes/opt.c
+arch/x86/kernel/kprobes/opt.c:468:13: warning: function 'arch_unoptimize_kprobes' with external linkage has definition
+  CC      arch/x86/kernel/kprobes/opt.o
+  CHECK   arch/x86/kernel/kprobes/ftrace.c
+  CC      arch/x86/kernel/kprobes/ftrace.o
+  AR      arch/x86/kernel/kprobes/built-in.a
+  CHECK   arch/x86/kernel/ptrace.c
+  CC      arch/x86/kernel/ptrace.o
+  CHECK   arch/x86/kernel/tls.c
+  CC      arch/x86/kernel/tls.o
+  CHECK   arch/x86/kernel/step.c
+  CC      arch/x86/kernel/step.o
+  CHECK   arch/x86/kernel/tboot.c
+arch/x86/kernel/tboot.c:478:16: warning: incorrect type in assignment (different address spaces)
+arch/x86/kernel/tboot.c:478:16:    expected void *config
+arch/x86/kernel/tboot.c:478:16:    got void [noderef] <asn:2> *
+arch/x86/kernel/tboot.c:484:19: warning: incorrect type in assignment (different address spaces)
+arch/x86/kernel/tboot.c:484:19:    expected void *heap_base
+arch/x86/kernel/tboot.c:484:19:    got void [noderef] <asn:2> *
+arch/x86/kernel/tboot.c:486:17: warning: incorrect type in argument 1 (different address spaces)
+arch/x86/kernel/tboot.c:486:17:    expected void volatile [noderef] <asn:2> *addr
+arch/x86/kernel/tboot.c:486:17:    got void *config
+  CC      arch/x86/kernel/tboot.o
+  CHECK   arch/x86/kernel/i8237.c
+  CC      arch/x86/kernel/i8237.o
+  CHECK   arch/x86/kernel/stacktrace.c
+  CC      arch/x86/kernel/stacktrace.o
+  CHECK   arch/x86/kernel/reboot.c
+  CC      arch/x86/kernel/reboot.o
+  CHECK   arch/x86/kernel/early-quirks.c
+arch/x86/kernel/early-quirks.c:632:49: warning: restricted pci_power_t degrades to integer
+arch/x86/kernel/early-quirks.c:638:57: warning: restricted pci_power_t degrades to integer
+  CC      arch/x86/kernel/early-quirks.o
+  CHECK   arch/x86/kernel/smp.c
+  CC      arch/x86/kernel/smp.o
+  CHECK   arch/x86/kernel/smpboot.c
+  CC      arch/x86/kernel/smpboot.o
+  CHECK   arch/x86/kernel/tsc_sync.c
+  CC      arch/x86/kernel/tsc_sync.o
+  CHECK   arch/x86/kernel/setup_percpu.c
+  CC      arch/x86/kernel/setup_percpu.o
+  CHECK   arch/x86/kernel/mpparse.c
+  CC      arch/x86/kernel/mpparse.o
+  CHECK   arch/x86/kernel/ftrace.c
+arch/x86/kernel/ftrace.c:37:5: warning: context imbalance in 'ftrace_arch_code_modify_prepare' - wrong count at exit
+arch/x86/kernel/ftrace.c:51:5: warning: context imbalance in 'ftrace_arch_code_modify_post_process' - wrong count at exit
+  CC      arch/x86/kernel/ftrace.o
+  CHECK   arch/x86/kernel/livepatch.c
+  CC      arch/x86/kernel/livepatch.o
+  AS      arch/x86/kernel/ftrace_64.o
+  CHECK   arch/x86/kernel/trace_clock.c
+  CC      arch/x86/kernel/trace_clock.o
+  CHECK   arch/x86/kernel/machine_kexec_64.c
+  CC      arch/x86/kernel/machine_kexec_64.o
+  AS      arch/x86/kernel/relocate_kernel_64.o
+  CHECK   arch/x86/kernel/crash.c
+  CC      arch/x86/kernel/crash.o
+  CHECK   arch/x86/kernel/kexec-bzimage64.c
+  CC      arch/x86/kernel/kexec-bzimage64.o
+  CHECK   arch/x86/kernel/crash_dump_64.c
+  CC      arch/x86/kernel/crash_dump_64.o
+  CHECK   arch/x86/kernel/module.c
+  CC      arch/x86/kernel/module.o
+  CHECK   arch/x86/kernel/doublefault.c
+  CC      arch/x86/kernel/doublefault.o
+  CHECK   arch/x86/kernel/kgdb.c
+  CC      arch/x86/kernel/kgdb.o
+  CHECK   arch/x86/kernel/early_printk.c
+  CC      arch/x86/kernel/early_printk.o
+  CHECK   arch/x86/kernel/hpet.c
+  CC      arch/x86/kernel/hpet.o
+  CHECK   arch/x86/kernel/apb_timer.c
+  CC      arch/x86/kernel/apb_timer.o
+  CHECK   arch/x86/kernel/amd_nb.c
+  CC      arch/x86/kernel/amd_nb.o
+  CHECK   arch/x86/kernel/nmi_selftest.c
+  CC      arch/x86/kernel/nmi_selftest.o
+  CHECK   arch/x86/kernel/kvm.c
+arch/x86/kernel/kvm.c:58:1: warning: symbol '__pcpu_scope_steal_time' was not declared. Should it be static?
+  CC      arch/x86/kernel/kvm.o
+  CHECK   arch/x86/kernel/kvmclock.c
+  CC      arch/x86/kernel/kvmclock.o
+  CHECK   arch/x86/kernel/paravirt.c
+  CC      arch/x86/kernel/paravirt.o
+  CHECK   arch/x86/kernel/paravirt_patch.c
+  CC      arch/x86/kernel/paravirt_patch.o
+  CHECK   arch/x86/kernel/paravirt-spinlocks.c
+  CC      arch/x86/kernel/paravirt-spinlocks.o
+  CHECK   arch/x86/kernel/pvclock.c
+  CC      arch/x86/kernel/pvclock.o
+  CHECK   arch/x86/kernel/pmem.c
+  CC      arch/x86/kernel/pmem.o
+  CHECK   arch/x86/kernel/jailhouse.c
+  CC      arch/x86/kernel/jailhouse.o
+  CHECK   arch/x86/kernel/eisa.c
+  CC      arch/x86/kernel/eisa.o
+  CHECK   arch/x86/kernel/pcspeaker.c
+  CC      arch/x86/kernel/pcspeaker.o
+  CHECK   arch/x86/kernel/check.c
+  CC      arch/x86/kernel/check.o
+  CHECK   arch/x86/kernel/pci-swiotlb.c
+  CC      arch/x86/kernel/pci-swiotlb.o
+  CHECK   arch/x86/kernel/devicetree.c
+  CC      arch/x86/kernel/devicetree.o
+  CHECK   arch/x86/kernel/uprobes.c
+  CC      arch/x86/kernel/uprobes.o
+  CHECK   arch/x86/kernel/sysfb.c
+  CC      arch/x86/kernel/sysfb.o
+  CHECK   arch/x86/kernel/sysfb_simplefb.c
+  CC      arch/x86/kernel/sysfb_simplefb.o
+  CHECK   arch/x86/kernel/sysfb_efi.c
+  CC      arch/x86/kernel/sysfb_efi.o
+  CHECK   arch/x86/kernel/perf_regs.c
+  CC      arch/x86/kernel/perf_regs.o
+  CHECK   arch/x86/kernel/tracepoint.c
+  CC      arch/x86/kernel/tracepoint.o
+  CHECK   arch/x86/kernel/itmt.c
+  CC      arch/x86/kernel/itmt.o
+  CHECK   arch/x86/kernel/umip.c
+arch/x86/kernel/umip.c:84:12: warning: symbol 'umip_insns' was not declared. Should it be static?
+  CC      arch/x86/kernel/umip.o
+  CHECK   arch/x86/kernel/unwind_orc.c
+arch/x86/kernel/unwind_orc.c:19:5: warning: symbol 'cur_orc_ip_table' was not declared. Should it be static?
+arch/x86/kernel/unwind_orc.c:20:18: warning: symbol 'cur_orc_table' was not declared. Should it be static?
+arch/x86/kernel/unwind_orc.c:22:14: warning: symbol 'lookup_num_blocks' was not declared. Should it be static?
+arch/x86/kernel/unwind_orc.c:23:6: warning: symbol 'orc_init' was not declared. Should it be static?
+  CC      arch/x86/kernel/unwind_orc.o
+  CHECK   arch/x86/kernel/audit_64.c
+  CC      arch/x86/kernel/audit_64.o
+  CHECK   arch/x86/kernel/amd_gart_64.c
+arch/x86/kernel/amd_gart_64.c:85:15: warning: symbol 'agp_memory_reserved' was not declared. Should it be static?
+arch/x86/kernel/amd_gart_64.c:86:17: warning: symbol 'agp_gatt_table' was not declared. Should it be static?
+  CC      arch/x86/kernel/amd_gart_64.o
+  CHECK   arch/x86/kernel/aperture_64.c
+  CC      arch/x86/kernel/aperture_64.o
+  CHECK   arch/x86/kernel/mmconf-fam10h_64.c
+  CC      arch/x86/kernel/mmconf-fam10h_64.o
+  CHECK   arch/x86/kernel/vsmp_64.c
+  CC      arch/x86/kernel/vsmp_64.o
+  CHECK   arch/x86/kernel/ima_arch.c
+arch/x86/kernel/ima_arch.c:13:46: error: invalid initializer
+arch/x86/kernel/ima_arch.c:14:45: error: invalid initializer
+  CC      arch/x86/kernel/ima_arch.o
+  AR      arch/x86/kernel/built-in.a
+  AS      arch/x86/kernel/head_64.o
+  CHECK   arch/x86/kernel/head64.c
+  CC      arch/x86/kernel/head64.o
+  CHECK   arch/x86/kernel/ebda.c
+  CC      arch/x86/kernel/ebda.o
+  CHECK   arch/x86/kernel/platform-quirks.c
+  CC      arch/x86/kernel/platform-quirks.o
+  LDS     arch/x86/kernel/vmlinux.lds
+  CHECK   arch/x86/kernel/msr.c
+  CC [M]  arch/x86/kernel/msr.o
+  CHECK   arch/x86/kernel/cpuid.c
+  CC [M]  arch/x86/kernel/cpuid.o
+  CHECK   arch/x86/kvm/../../../virt/kvm/kvm_main.c
+arch/x86/kvm/../../../virt/kvm/kvm_main.c:3035:57: warning: cast removes address space '<asn:1>' of expression
+arch/x86/kvm/../../../virt/kvm/kvm_main.c:3035:57: warning: incorrect type in argument 2 (different address spaces)
+arch/x86/kvm/../../../virt/kvm/kvm_main.c:3035:57:    expected struct compat_sigset_t const [noderef] [usertype] <asn:1> *compat
+arch/x86/kvm/../../../virt/kvm/kvm_main.c:3035:57:    got void *
+arch/x86/kvm/../../../virt/kvm/kvm_main.c:666:12: warning: symbol 'kvm_arch_post_init_vm' was not declared. Should it be static?
+arch/x86/kvm/../../../virt/kvm/kvm_main.c:675:13: warning: symbol 'kvm_arch_pre_destroy_vm' was not declared. Should it be static?
+  CC [M]  arch/x86/kvm/../../../virt/kvm/kvm_main.o
+  CHECK   arch/x86/kvm/../../../virt/kvm/coalesced_mmio.c
+  CC [M]  arch/x86/kvm/../../../virt/kvm/coalesced_mmio.o
+  CHECK   arch/x86/kvm/../../../virt/kvm/eventfd.c
+  CC [M]  arch/x86/kvm/../../../virt/kvm/eventfd.o
+  CHECK   arch/x86/kvm/../../../virt/kvm/irqchip.c
+  CC [M]  arch/x86/kvm/../../../virt/kvm/irqchip.o
+  CHECK   arch/x86/kvm/../../../virt/kvm/vfio.c
+  CC [M]  arch/x86/kvm/../../../virt/kvm/vfio.o
+  CHECK   arch/x86/kvm/../../../virt/kvm/async_pf.c
+  CC [M]  arch/x86/kvm/../../../virt/kvm/async_pf.o
+  CHECK   arch/x86/kvm/x86.c
+arch/x86/kvm/x86.c:2530:38: warning: incorrect type in argument 1 (different address spaces)
+arch/x86/kvm/x86.c:2530:38:    expected void const [noderef] <asn:1> *
+arch/x86/kvm/x86.c:2530:38:    got unsigned char [usertype] *
+arch/x86/kvm/x86.c:7389:15: error: incompatible types in comparison expression (different address spaces):
+arch/x86/kvm/x86.c:7389:15:    struct kvm_apic_map [noderef] <asn:4> *
+arch/x86/kvm/x86.c:7389:15:    struct kvm_apic_map *
+arch/x86/kvm/x86.c:9536:5: warning: symbol 'kvm_arch_post_init_vm' was not declared. Should it be static?
+arch/x86/kvm/x86.c:9642:6: warning: symbol 'kvm_arch_pre_destroy_vm' was not declared. Should it be static?
+arch/x86/kvm/x86.c:9664:16: error: incompatible types in comparison expression (different address spaces):
+arch/x86/kvm/x86.c:9664:16:    struct kvm_apic_map [noderef] <asn:4> *
+arch/x86/kvm/x86.c:9664:16:    struct kvm_apic_map *
+arch/x86/kvm/x86.c:9665:15: error: incompatible types in comparison expression (different address spaces):
+arch/x86/kvm/x86.c:9665:15:    struct kvm_pmu_event_filter [noderef] <asn:4> *
+arch/x86/kvm/x86.c:9665:15:    struct kvm_pmu_event_filter *
+./include/linux/srcu.h:179:9: warning: context imbalance in 'vcpu_enter_guest' - unexpected unlock
+  CC [M]  arch/x86/kvm/x86.o
+  CHECK   arch/x86/kvm/emulate.c
+arch/x86/kvm/emulate.c:5471:21: error: arithmetics on pointers to functions
+  CC [M]  arch/x86/kvm/emulate.o
+  CHECK   arch/x86/kvm/i8259.c
+  CC [M]  arch/x86/kvm/i8259.o
+  CHECK   arch/x86/kvm/irq.c
+  CC [M]  arch/x86/kvm/irq.o
+  CHECK   arch/x86/kvm/lapic.c
+arch/x86/kvm/lapic.c:239:15: error: incompatible types in comparison expression (different address spaces):
+arch/x86/kvm/lapic.c:239:15:    struct kvm_apic_map [noderef] <asn:4> *
+arch/x86/kvm/lapic.c:239:15:    struct kvm_apic_map *
+arch/x86/kvm/lapic.c:241:9: error: incompatible types in comparison expression (different address spaces):
+arch/x86/kvm/lapic.c:241:9:    struct kvm_apic_map [noderef] <asn:4> *
+arch/x86/kvm/lapic.c:241:9:    struct kvm_apic_map *
+arch/x86/kvm/lapic.c:598:15: error: incompatible types in comparison expression (different address spaces):
+arch/x86/kvm/lapic.c:598:15:    struct kvm_apic_map [noderef] <asn:4> *
+arch/x86/kvm/lapic.c:598:15:    struct kvm_apic_map *
+arch/x86/kvm/lapic.c:953:15: error: incompatible types in comparison expression (different address spaces):
+arch/x86/kvm/lapic.c:953:15:    struct kvm_apic_map [noderef] <asn:4> *
+arch/x86/kvm/lapic.c:953:15:    struct kvm_apic_map *
+arch/x86/kvm/lapic.c:995:15: error: incompatible types in comparison expression (different address spaces):
+arch/x86/kvm/lapic.c:995:15:    struct kvm_apic_map [noderef] <asn:4> *
+arch/x86/kvm/lapic.c:995:15:    struct kvm_apic_map *
+arch/x86/kvm/lapic.c:1138:15: error: incompatible types in comparison expression (different address spaces):
+arch/x86/kvm/lapic.c:1138:15:    struct kvm_apic_map [noderef] <asn:4> *
+arch/x86/kvm/lapic.c:1138:15:    struct kvm_apic_map *
+  CC [M]  arch/x86/kvm/lapic.o
+  CHECK   arch/x86/kvm/i8254.c
+  CC [M]  arch/x86/kvm/i8254.o
+  CHECK   arch/x86/kvm/ioapic.c
+  CC [M]  arch/x86/kvm/ioapic.o
+  CHECK   arch/x86/kvm/irq_comm.c
+  CC [M]  arch/x86/kvm/irq_comm.o
+  CHECK   arch/x86/kvm/cpuid.c
+  CC [M]  arch/x86/kvm/cpuid.o
+  CHECK   arch/x86/kvm/pmu.c
+arch/x86/kvm/pmu.c:190:18: error: incompatible types in comparison expression (different address spaces):
+arch/x86/kvm/pmu.c:190:18:    struct kvm_pmu_event_filter [noderef] <asn:4> *
+arch/x86/kvm/pmu.c:190:18:    struct kvm_pmu_event_filter *
+arch/x86/kvm/pmu.c:251:18: error: incompatible types in comparison expression (different address spaces):
+arch/x86/kvm/pmu.c:251:18:    struct kvm_pmu_event_filter [noderef] <asn:4> *
+arch/x86/kvm/pmu.c:251:18:    struct kvm_pmu_event_filter *
+arch/x86/kvm/pmu.c:511:18: error: incompatible types in comparison expression (different address spaces):
+arch/x86/kvm/pmu.c:511:18:    struct kvm_pmu_event_filter [noderef] <asn:4> *
+arch/x86/kvm/pmu.c:511:18:    struct kvm_pmu_event_filter *
+arch/x86/kvm/pmu.c:511:18: error: incompatible types in comparison expression (different address spaces):
+arch/x86/kvm/pmu.c:511:18:    struct kvm_pmu_event_filter [noderef] <asn:4> *
+arch/x86/kvm/pmu.c:511:18:    struct kvm_pmu_event_filter *
+  CC [M]  arch/x86/kvm/pmu.o
+  CHECK   arch/x86/kvm/mtrr.c
+  CC [M]  arch/x86/kvm/mtrr.o
+  CHECK   arch/x86/kvm/hyperv.c
+  CC [M]  arch/x86/kvm/hyperv.o
+  CHECK   arch/x86/kvm/debugfs.c
+  CC [M]  arch/x86/kvm/debugfs.o
+  CHECK   arch/x86/kvm/mmu/mmu.c
+arch/x86/kvm/mmu/mmu.c:4759:57: warning: cast truncates bits from constant value (ffffff33 becomes 33)
+arch/x86/kvm/mmu/mmu.c:4761:56: warning: cast truncates bits from constant value (ffffff0f becomes f)
+arch/x86/kvm/mmu/mmu.c:4763:57: warning: cast truncates bits from constant value (ffffff55 becomes 55)
+  CC [M]  arch/x86/kvm/mmu/mmu.o
+  CHECK   arch/x86/kvm/mmu/page_track.c
+  CC [M]  arch/x86/kvm/mmu/page_track.o
+  LD [M]  arch/x86/kvm/kvm.o
+  CHECK   arch/x86/kvm/vmx/vmx.c
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (110011 becomes 11)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (110011 becomes 11)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100110 becomes 110)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100490 becomes 490)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100310 becomes 310)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100510 becomes 510)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100410 becomes 410)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100490 becomes 490)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100310 becomes 310)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100510 becomes 510)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100410 becomes 410)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (30203 becomes 203)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (30203 becomes 203)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (30283 becomes 283)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (30283 becomes 283)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1b019b becomes 19b)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1b021b becomes 21b)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1b029b becomes 29b)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1b031b becomes 31b)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1b041b becomes 41b)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80c88 becomes c88)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a081a becomes 81a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a081a becomes 81a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a081a becomes 81a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120912 becomes 912)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120912 becomes 912)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120912 becomes 912)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (110311 becomes 311)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120992 becomes 992)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120992 becomes 992)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100610 becomes 610)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100690 becomes 690)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100590 becomes 590)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80408 becomes 408)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a039a becomes 39a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a041a becomes 41a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120a92 becomes a92)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a099a becomes 99a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a091a becomes 91a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a048a becomes 48a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a039a becomes 39a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a041a becomes 41a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120a92 becomes a92)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a099a becomes 99a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a091a becomes 91a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a048a becomes 48a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a010a becomes 10a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a050a becomes 50a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a071a becomes 71a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a079a becomes 79a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a009a becomes 9a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a081a becomes 81a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a081a becomes 81a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a011a becomes 11a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (180198 becomes 198)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a011a becomes 11a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a051a becomes 51a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120392 becomes 392)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120892 becomes 892)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a081a becomes 81a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a081a becomes 81a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a011a becomes 11a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a011a becomes 11a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100490 becomes 490)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100490 becomes 490)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120892 becomes 892)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120892 becomes 892)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100490 becomes 490)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a001a becomes 1a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a011a becomes 11a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a028a becomes 28a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a030a becomes 30a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a038a becomes 38a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a040a becomes 40a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a028a becomes 28a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a030a becomes 30a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a038a becomes 38a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a040a becomes 40a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100090 becomes 90)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100090 becomes 90)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (180118 becomes 118)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a001a becomes 1a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80688 becomes 688)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a009a becomes 9a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100790 becomes 790)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100790 becomes 790)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (180198 becomes 198)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a011a becomes 11a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120492 becomes 492)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a061a becomes 61a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120492 becomes 492)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a061a becomes 61a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120412 becomes 412)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a059a becomes 59a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120412 becomes 412)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a059a becomes 59a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (20402 becomes 402)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1b001b becomes 1b)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1b009b becomes 9b)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: too many warnings
+  CC [M]  arch/x86/kvm/vmx/vmx.o
+  AS [M]  arch/x86/kvm/vmx/vmenter.o
+  CHECK   arch/x86/kvm/vmx/pmu_intel.c
+  CC [M]  arch/x86/kvm/vmx/pmu_intel.o
+  CHECK   arch/x86/kvm/vmx/vmcs12.c
+arch/x86/kvm/vmx/vmcs12.c:15:9: warning: cast truncates bits from constant value (20002 becomes 2)
+arch/x86/kvm/vmx/vmcs12.c:16:9: warning: cast truncates bits from constant value (20082 becomes 82)
+arch/x86/kvm/vmx/vmcs12.c:17:9: warning: cast truncates bits from constant value (20102 becomes 102)
+arch/x86/kvm/vmx/vmcs12.c:18:9: warning: cast truncates bits from constant value (20182 becomes 182)
+arch/x86/kvm/vmx/vmcs12.c:19:9: warning: cast truncates bits from constant value (20202 becomes 202)
+arch/x86/kvm/vmx/vmcs12.c:20:9: warning: cast truncates bits from constant value (20282 becomes 282)
+arch/x86/kvm/vmx/vmcs12.c:21:9: warning: cast truncates bits from constant value (20302 becomes 302)
+arch/x86/kvm/vmx/vmcs12.c:22:9: warning: cast truncates bits from constant value (20382 becomes 382)
+arch/x86/kvm/vmx/vmcs12.c:23:9: warning: cast truncates bits from constant value (20402 becomes 402)
+arch/x86/kvm/vmx/vmcs12.c:24:9: warning: cast truncates bits from constant value (20482 becomes 482)
+arch/x86/kvm/vmx/vmcs12.c:25:9: warning: cast truncates bits from constant value (30003 becomes 3)
+arch/x86/kvm/vmx/vmcs12.c:26:9: warning: cast truncates bits from constant value (30083 becomes 83)
+arch/x86/kvm/vmx/vmcs12.c:27:9: warning: cast truncates bits from constant value (30103 becomes 103)
+arch/x86/kvm/vmx/vmcs12.c:28:9: warning: cast truncates bits from constant value (30183 becomes 183)
+arch/x86/kvm/vmx/vmcs12.c:29:9: warning: cast truncates bits from constant value (30203 becomes 203)
+arch/x86/kvm/vmx/vmcs12.c:30:9: warning: cast truncates bits from constant value (30283 becomes 283)
+arch/x86/kvm/vmx/vmcs12.c:31:9: warning: cast truncates bits from constant value (30303 becomes 303)
+arch/x86/kvm/vmx/vmcs12.c:32:9: warning: cast truncates bits from constant value (80008 becomes 8)
+arch/x86/kvm/vmx/vmcs12.c:32:9: warning: cast truncates bits from constant value (80048 becomes 48)
+arch/x86/kvm/vmx/vmcs12.c:33:9: warning: cast truncates bits from constant value (80088 becomes 88)
+arch/x86/kvm/vmx/vmcs12.c:33:9: warning: cast truncates bits from constant value (800c8 becomes c8)
+arch/x86/kvm/vmx/vmcs12.c:34:9: warning: cast truncates bits from constant value (80108 becomes 108)
+arch/x86/kvm/vmx/vmcs12.c:34:9: warning: cast truncates bits from constant value (80148 becomes 148)
+arch/x86/kvm/vmx/vmcs12.c:35:9: warning: cast truncates bits from constant value (80188 becomes 188)
+arch/x86/kvm/vmx/vmcs12.c:35:9: warning: cast truncates bits from constant value (801c8 becomes 1c8)
+arch/x86/kvm/vmx/vmcs12.c:36:9: warning: cast truncates bits from constant value (80208 becomes 208)
+arch/x86/kvm/vmx/vmcs12.c:36:9: warning: cast truncates bits from constant value (80248 becomes 248)
+arch/x86/kvm/vmx/vmcs12.c:37:9: warning: cast truncates bits from constant value (80288 becomes 288)
+arch/x86/kvm/vmx/vmcs12.c:37:9: warning: cast truncates bits from constant value (802c8 becomes 2c8)
+arch/x86/kvm/vmx/vmcs12.c:38:9: warning: cast truncates bits from constant value (80388 becomes 388)
+arch/x86/kvm/vmx/vmcs12.c:38:9: warning: cast truncates bits from constant value (803c8 becomes 3c8)
+arch/x86/kvm/vmx/vmcs12.c:39:9: warning: cast truncates bits from constant value (80408 becomes 408)
+arch/x86/kvm/vmx/vmcs12.c:39:9: warning: cast truncates bits from constant value (80448 becomes 448)
+arch/x86/kvm/vmx/vmcs12.c:40:9: warning: cast truncates bits from constant value (80488 becomes 488)
+arch/x86/kvm/vmx/vmcs12.c:40:9: warning: cast truncates bits from constant value (804c8 becomes 4c8)
+arch/x86/kvm/vmx/vmcs12.c:41:9: warning: cast truncates bits from constant value (80508 becomes 508)
+arch/x86/kvm/vmx/vmcs12.c:41:9: warning: cast truncates bits from constant value (80548 becomes 548)
+arch/x86/kvm/vmx/vmcs12.c:42:9: warning: cast truncates bits from constant value (80588 becomes 588)
+arch/x86/kvm/vmx/vmcs12.c:42:9: warning: cast truncates bits from constant value (805c8 becomes 5c8)
+arch/x86/kvm/vmx/vmcs12.c:43:9: warning: cast truncates bits from constant value (80608 becomes 608)
+arch/x86/kvm/vmx/vmcs12.c:43:9: warning: cast truncates bits from constant value (80648 becomes 648)
+arch/x86/kvm/vmx/vmcs12.c:44:9: warning: cast truncates bits from constant value (80688 becomes 688)
+arch/x86/kvm/vmx/vmcs12.c:44:9: warning: cast truncates bits from constant value (806c8 becomes 6c8)
+arch/x86/kvm/vmx/vmcs12.c:45:9: warning: cast truncates bits from constant value (80708 becomes 708)
+arch/x86/kvm/vmx/vmcs12.c:45:9: warning: cast truncates bits from constant value (80748 becomes 748)
+arch/x86/kvm/vmx/vmcs12.c:46:9: warning: cast truncates bits from constant value (80788 becomes 788)
+arch/x86/kvm/vmx/vmcs12.c:46:9: warning: cast truncates bits from constant value (807c8 becomes 7c8)
+arch/x86/kvm/vmx/vmcs12.c:47:9: warning: cast truncates bits from constant value (80808 becomes 808)
+arch/x86/kvm/vmx/vmcs12.c:47:9: warning: cast truncates bits from constant value (80848 becomes 848)
+arch/x86/kvm/vmx/vmcs12.c:48:9: warning: cast truncates bits from constant value (80888 becomes 888)
+arch/x86/kvm/vmx/vmcs12.c:48:9: warning: cast truncates bits from constant value (808c8 becomes 8c8)
+arch/x86/kvm/vmx/vmcs12.c:49:9: warning: cast truncates bits from constant value (80908 becomes 908)
+arch/x86/kvm/vmx/vmcs12.c:49:9: warning: cast truncates bits from constant value (80948 becomes 948)
+arch/x86/kvm/vmx/vmcs12.c:50:9: warning: cast truncates bits from constant value (80988 becomes 988)
+arch/x86/kvm/vmx/vmcs12.c:50:9: warning: cast truncates bits from constant value (809c8 becomes 9c8)
+arch/x86/kvm/vmx/vmcs12.c:51:9: warning: cast truncates bits from constant value (80a08 becomes a08)
+arch/x86/kvm/vmx/vmcs12.c:51:9: warning: cast truncates bits from constant value (80a48 becomes a48)
+arch/x86/kvm/vmx/vmcs12.c:52:9: warning: cast truncates bits from constant value (80b08 becomes b08)
+arch/x86/kvm/vmx/vmcs12.c:52:9: warning: cast truncates bits from constant value (80b48 becomes b48)
+arch/x86/kvm/vmx/vmcs12.c:53:9: warning: cast truncates bits from constant value (90009 becomes 9)
+arch/x86/kvm/vmx/vmcs12.c:53:9: warning: cast truncates bits from constant value (90049 becomes 49)
+arch/x86/kvm/vmx/vmcs12.c:54:9: warning: cast truncates bits from constant value (a000a becomes a)
+arch/x86/kvm/vmx/vmcs12.c:54:9: warning: cast truncates bits from constant value (a004a becomes 4a)
+arch/x86/kvm/vmx/vmcs12.c:55:9: warning: cast truncates bits from constant value (a008a becomes 8a)
+arch/x86/kvm/vmx/vmcs12.c:55:9: warning: cast truncates bits from constant value (a00ca becomes ca)
+arch/x86/kvm/vmx/vmcs12.c:56:9: warning: cast truncates bits from constant value (a010a becomes 10a)
+arch/x86/kvm/vmx/vmcs12.c:56:9: warning: cast truncates bits from constant value (a014a becomes 14a)
+arch/x86/kvm/vmx/vmcs12.c:57:9: warning: cast truncates bits from constant value (a018a becomes 18a)
+arch/x86/kvm/vmx/vmcs12.c:57:9: warning: cast truncates bits from constant value (a01ca becomes 1ca)
+arch/x86/kvm/vmx/vmcs12.c:58:9: warning: cast truncates bits from constant value (a020a becomes 20a)
+arch/x86/kvm/vmx/vmcs12.c:58:9: warning: cast truncates bits from constant value (a024a becomes 24a)
+arch/x86/kvm/vmx/vmcs12.c:59:9: warning: cast truncates bits from constant value (a028a becomes 28a)
+arch/x86/kvm/vmx/vmcs12.c:59:9: warning: cast truncates bits from constant value (a02ca becomes 2ca)
+arch/x86/kvm/vmx/vmcs12.c:60:9: warning: cast truncates bits from constant value (a030a becomes 30a)
+arch/x86/kvm/vmx/vmcs12.c:60:9: warning: cast truncates bits from constant value (a034a becomes 34a)
+arch/x86/kvm/vmx/vmcs12.c:61:9: warning: cast truncates bits from constant value (a038a becomes 38a)
+arch/x86/kvm/vmx/vmcs12.c:61:9: warning: cast truncates bits from constant value (a03ca becomes 3ca)
+arch/x86/kvm/vmx/vmcs12.c:62:9: warning: cast truncates bits from constant value (a040a becomes 40a)
+arch/x86/kvm/vmx/vmcs12.c:62:9: warning: cast truncates bits from constant value (a044a becomes 44a)
+arch/x86/kvm/vmx/vmcs12.c:63:9: warning: cast truncates bits from constant value (a048a becomes 48a)
+arch/x86/kvm/vmx/vmcs12.c:63:9: warning: cast truncates bits from constant value (a04ca becomes 4ca)
+arch/x86/kvm/vmx/vmcs12.c:64:9: warning: cast truncates bits from constant value (b000b becomes b)
+arch/x86/kvm/vmx/vmcs12.c:64:9: warning: cast truncates bits from constant value (b004b becomes 4b)
+arch/x86/kvm/vmx/vmcs12.c:65:9: warning: cast truncates bits from constant value (b008b becomes 8b)
+arch/x86/kvm/vmx/vmcs12.c:65:9: warning: cast truncates bits from constant value (b00cb becomes cb)
+arch/x86/kvm/vmx/vmcs12.c:66:9: warning: cast truncates bits from constant value (b010b becomes 10b)
+arch/x86/kvm/vmx/vmcs12.c:66:9: warning: cast truncates bits from constant value (b014b becomes 14b)
+arch/x86/kvm/vmx/vmcs12.c:67:9: warning: cast truncates bits from constant value (100010 becomes 10)
+arch/x86/kvm/vmx/vmcs12.c:68:9: warning: cast truncates bits from constant value (100090 becomes 90)
+arch/x86/kvm/vmx/vmcs12.c:69:9: warning: cast truncates bits from constant value (100110 becomes 110)
+arch/x86/kvm/vmx/vmcs12.c:70:9: warning: cast truncates bits from constant value (100190 becomes 190)
+arch/x86/kvm/vmx/vmcs12.c:71:9: warning: cast truncates bits from constant value (100210 becomes 210)
+arch/x86/kvm/vmx/vmcs12.c:72:9: warning: cast truncates bits from constant value (100290 becomes 290)
+arch/x86/kvm/vmx/vmcs12.c:73:9: warning: cast truncates bits from constant value (100310 becomes 310)
+arch/x86/kvm/vmx/vmcs12.c:74:9: warning: cast truncates bits from constant value (100390 becomes 390)
+arch/x86/kvm/vmx/vmcs12.c:75:9: warning: cast truncates bits from constant value (100410 becomes 410)
+arch/x86/kvm/vmx/vmcs12.c:76:9: warning: cast truncates bits from constant value (100490 becomes 490)
+arch/x86/kvm/vmx/vmcs12.c:77:9: warning: cast truncates bits from constant value (100510 becomes 510)
+arch/x86/kvm/vmx/vmcs12.c:78:9: warning: cast truncates bits from constant value (100590 becomes 590)
+arch/x86/kvm/vmx/vmcs12.c:79:9: warning: too many warnings
+  CC [M]  arch/x86/kvm/vmx/vmcs12.o
+  CHECK   arch/x86/kvm/vmx/evmcs.c
+arch/x86/kvm/vmx/evmcs.c:22:9: warning: cast truncates bits from constant value (1a079a becomes 79a)
+arch/x86/kvm/vmx/evmcs.c:24:9: warning: cast truncates bits from constant value (1a071a becomes 71a)
+arch/x86/kvm/vmx/evmcs.c:26:9: warning: cast truncates bits from constant value (1a081a becomes 81a)
+arch/x86/kvm/vmx/evmcs.c:28:9: warning: cast truncates bits from constant value (b000b becomes b)
+arch/x86/kvm/vmx/evmcs.c:30:9: warning: cast truncates bits from constant value (b008b becomes 8b)
+arch/x86/kvm/vmx/evmcs.c:32:9: warning: cast truncates bits from constant value (1b001b becomes 1b)
+arch/x86/kvm/vmx/evmcs.c:34:9: warning: cast truncates bits from constant value (1b009b becomes 9b)
+arch/x86/kvm/vmx/evmcs.c:36:9: warning: cast truncates bits from constant value (1b011b becomes 11b)
+arch/x86/kvm/vmx/evmcs.c:38:9: warning: cast truncates bits from constant value (1b041b becomes 41b)
+arch/x86/kvm/vmx/evmcs.c:40:9: warning: cast truncates bits from constant value (1b049b becomes 49b)
+arch/x86/kvm/vmx/evmcs.c:42:9: warning: cast truncates bits from constant value (1b059b becomes 59b)
+arch/x86/kvm/vmx/evmcs.c:44:9: warning: cast truncates bits from constant value (80008 becomes 8)
+arch/x86/kvm/vmx/evmcs.c:46:9: warning: cast truncates bits from constant value (80088 becomes 88)
+arch/x86/kvm/vmx/evmcs.c:48:9: warning: cast truncates bits from constant value (80108 becomes 108)
+arch/x86/kvm/vmx/evmcs.c:50:9: warning: cast truncates bits from constant value (1a019a becomes 19a)
+arch/x86/kvm/vmx/evmcs.c:52:9: warning: cast truncates bits from constant value (1a021a becomes 21a)
+arch/x86/kvm/vmx/evmcs.c:54:9: warning: cast truncates bits from constant value (1a029a becomes 29a)
+arch/x86/kvm/vmx/evmcs.c:56:9: warning: cast truncates bits from constant value (1a031a becomes 31a)
+arch/x86/kvm/vmx/evmcs.c:58:9: warning: cast truncates bits from constant value (1a039a becomes 39a)
+arch/x86/kvm/vmx/evmcs.c:60:9: warning: cast truncates bits from constant value (1a041a becomes 41a)
+arch/x86/kvm/vmx/evmcs.c:62:9: warning: cast truncates bits from constant value (1a049a becomes 49a)
+arch/x86/kvm/vmx/evmcs.c:64:9: warning: cast truncates bits from constant value (1a051a becomes 51a)
+arch/x86/kvm/vmx/evmcs.c:66:9: warning: cast truncates bits from constant value (1a059a becomes 59a)
+arch/x86/kvm/vmx/evmcs.c:68:9: warning: cast truncates bits from constant value (1a061a becomes 61a)
+arch/x86/kvm/vmx/evmcs.c:70:9: warning: cast truncates bits from constant value (80408 becomes 408)
+arch/x86/kvm/vmx/evmcs.c:72:9: warning: cast truncates bits from constant value (80488 becomes 488)
+arch/x86/kvm/vmx/evmcs.c:74:9: warning: cast truncates bits from constant value (a000a becomes a)
+arch/x86/kvm/vmx/evmcs.c:76:9: warning: cast truncates bits from constant value (a008a becomes 8a)
+arch/x86/kvm/vmx/evmcs.c:78:9: warning: cast truncates bits from constant value (a010a becomes 10a)
+arch/x86/kvm/vmx/evmcs.c:80:9: warning: cast truncates bits from constant value (a018a becomes 18a)
+arch/x86/kvm/vmx/evmcs.c:82:9: warning: cast truncates bits from constant value (a028a becomes 28a)
+arch/x86/kvm/vmx/evmcs.c:84:9: warning: cast truncates bits from constant value (a030a becomes 30a)
+arch/x86/kvm/vmx/evmcs.c:86:9: warning: cast truncates bits from constant value (a038a becomes 38a)
+arch/x86/kvm/vmx/evmcs.c:88:9: warning: cast truncates bits from constant value (a040a becomes 40a)
+arch/x86/kvm/vmx/evmcs.c:90:9: warning: cast truncates bits from constant value (1a089a becomes 89a)
+arch/x86/kvm/vmx/evmcs.c:92:9: warning: cast truncates bits from constant value (1a091a becomes 91a)
+arch/x86/kvm/vmx/evmcs.c:94:9: warning: cast truncates bits from constant value (1a099a becomes 99a)
+arch/x86/kvm/vmx/evmcs.c:96:9: warning: cast truncates bits from constant value (180018 becomes 18)
+arch/x86/kvm/vmx/evmcs.c:98:9: warning: cast truncates bits from constant value (180098 becomes 98)
+arch/x86/kvm/vmx/evmcs.c:100:9: warning: cast truncates bits from constant value (180118 becomes 118)
+arch/x86/kvm/vmx/evmcs.c:102:9: warning: cast truncates bits from constant value (180198 becomes 198)
+arch/x86/kvm/vmx/evmcs.c:104:9: warning: cast truncates bits from constant value (1a001a becomes 1a)
+arch/x86/kvm/vmx/evmcs.c:106:9: warning: cast truncates bits from constant value (1a009a becomes 9a)
+arch/x86/kvm/vmx/evmcs.c:108:9: warning: cast truncates bits from constant value (1a011a becomes 11a)
+arch/x86/kvm/vmx/evmcs.c:110:9: warning: cast truncates bits from constant value (1a069a becomes 69a)
+arch/x86/kvm/vmx/evmcs.c:112:9: warning: cast truncates bits from constant value (1b019b becomes 19b)
+arch/x86/kvm/vmx/evmcs.c:114:9: warning: cast truncates bits from constant value (1b021b becomes 21b)
+arch/x86/kvm/vmx/evmcs.c:116:9: warning: cast truncates bits from constant value (1b029b becomes 29b)
+arch/x86/kvm/vmx/evmcs.c:118:9: warning: cast truncates bits from constant value (1b031b becomes 31b)
+arch/x86/kvm/vmx/evmcs.c:120:9: warning: cast truncates bits from constant value (1b039b becomes 39b)
+arch/x86/kvm/vmx/evmcs.c:122:9: warning: cast truncates bits from constant value (1b051b becomes 51b)
+arch/x86/kvm/vmx/evmcs.c:124:9: warning: cast truncates bits from constant value (80688 becomes 688)
+arch/x86/kvm/vmx/evmcs.c:126:9: warning: cast truncates bits from constant value (a048a becomes 48a)
+arch/x86/kvm/vmx/evmcs.c:128:9: warning: cast truncates bits from constant value (80b08 becomes b08)
+arch/x86/kvm/vmx/evmcs.c:132:9: warning: cast truncates bits from constant value (90009 becomes 9)
+arch/x86/kvm/vmx/evmcs.c:134:9: warning: cast truncates bits from constant value (190019 becomes 19)
+arch/x86/kvm/vmx/evmcs.c:148:9: warning: cast truncates bits from constant value (190299 becomes 299)
+arch/x86/kvm/vmx/evmcs.c:156:9: warning: cast truncates bits from constant value (80188 becomes 188)
+arch/x86/kvm/vmx/evmcs.c:158:9: warning: cast truncates bits from constant value (80208 becomes 208)
+arch/x86/kvm/vmx/evmcs.c:160:9: warning: cast truncates bits from constant value (80288 becomes 288)
+arch/x86/kvm/vmx/evmcs.c:162:9: warning: cast truncates bits from constant value (180218 becomes 218)
+arch/x86/kvm/vmx/evmcs.c:164:9: warning: cast truncates bits from constant value (180298 becomes 298)
+arch/x86/kvm/vmx/evmcs.c:166:9: warning: cast truncates bits from constant value (180318 becomes 318)
+arch/x86/kvm/vmx/evmcs.c:168:9: warning: cast truncates bits from constant value (180398 becomes 398)
+arch/x86/kvm/vmx/evmcs.c:172:9: warning: cast truncates bits from constant value (100710 becomes 710)
+arch/x86/kvm/vmx/evmcs.c:174:9: warning: cast truncates bits from constant value (120912 becomes 912)
+arch/x86/kvm/vmx/evmcs.c:176:9: warning: cast truncates bits from constant value (100090 becomes 90)
+arch/x86/kvm/vmx/evmcs.c:178:9: warning: cast truncates bits from constant value (100110 becomes 110)
+arch/x86/kvm/vmx/evmcs.c:180:9: warning: cast truncates bits from constant value (100490 becomes 490)
+arch/x86/kvm/vmx/evmcs.c:182:9: warning: cast truncates bits from constant value (100590 becomes 590)
+arch/x86/kvm/vmx/evmcs.c:184:9: warning: cast truncates bits from constant value (100610 becomes 610)
+arch/x86/kvm/vmx/evmcs.c:187:9: warning: cast truncates bits from constant value (100690 becomes 690)
+arch/x86/kvm/vmx/evmcs.c:189:9: warning: cast truncates bits from constant value (130013 becomes 13)
+arch/x86/kvm/vmx/evmcs.c:191:9: warning: cast truncates bits from constant value (100010 becomes 10)
+arch/x86/kvm/vmx/evmcs.c:193:9: warning: cast truncates bits from constant value (100310 becomes 310)
+arch/x86/kvm/vmx/evmcs.c:195:9: warning: cast truncates bits from constant value (100790 becomes 790)
+arch/x86/kvm/vmx/evmcs.c:197:9: warning: cast truncates bits from constant value (120012 becomes 12)
+arch/x86/kvm/vmx/evmcs.c:199:9: warning: cast truncates bits from constant value (120092 becomes 92)
+arch/x86/kvm/vmx/evmcs.c:201:9: warning: cast truncates bits from constant value (120112 becomes 112)
+arch/x86/kvm/vmx/evmcs.c:203:9: warning: cast truncates bits from constant value (120192 becomes 192)
+arch/x86/kvm/vmx/evmcs.c:205:9: warning: cast truncates bits from constant value (120212 becomes 212)
+arch/x86/kvm/vmx/evmcs.c:207:9: warning: cast truncates bits from constant value (120292 becomes 292)
+arch/x86/kvm/vmx/evmcs.c:209:9: warning: cast truncates bits from constant value (120312 becomes 312)
+arch/x86/kvm/vmx/evmcs.c:211:9: warning: cast truncates bits from constant value (120392 becomes 392)
+arch/x86/kvm/vmx/evmcs.c:213:9: warning: cast truncates bits from constant value (120412 becomes 412)
+arch/x86/kvm/vmx/evmcs.c:215:9: warning: cast truncates bits from constant value (120492 becomes 492)
+arch/x86/kvm/vmx/evmcs.c:217:9: warning: cast truncates bits from constant value (120512 becomes 512)
+arch/x86/kvm/vmx/evmcs.c:219:9: warning: cast truncates bits from constant value (120592 becomes 592)
+arch/x86/kvm/vmx/evmcs.c:221:9: warning: cast truncates bits from constant value (120612 becomes 612)
+arch/x86/kvm/vmx/evmcs.c:223:9: warning: cast truncates bits from constant value (120692 becomes 692)
+arch/x86/kvm/vmx/evmcs.c:225:9: warning: cast truncates bits from constant value (120712 becomes 712)
+arch/x86/kvm/vmx/evmcs.c:227:9: warning: cast truncates bits from constant value (120792 becomes 792)
+arch/x86/kvm/vmx/evmcs.c:229:9: warning: cast truncates bits from constant value (120812 becomes 812)
+arch/x86/kvm/vmx/evmcs.c:231:9: warning: cast truncates bits from constant value (120892 becomes 892)
+arch/x86/kvm/vmx/evmcs.c:233:9: warning: cast truncates bits from constant value (120992 becomes 992)
+arch/x86/kvm/vmx/evmcs.c:235:9: warning: cast truncates bits from constant value (120a92 becomes a92)
+arch/x86/kvm/vmx/evmcs.c:239:9: warning: cast truncates bits from constant value (110011 becomes 11)
+arch/x86/kvm/vmx/evmcs.c:241:9: warning: cast truncates bits from constant value (110091 becomes 91)
+arch/x86/kvm/vmx/evmcs.c:243:9: warning: cast truncates bits from constant value (110111 becomes 111)
+arch/x86/kvm/vmx/evmcs.c:245:9: warning: too many warnings
+  CC [M]  arch/x86/kvm/vmx/evmcs.o
+  CHECK   arch/x86/kvm/vmx/nested.c
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100790 becomes 790)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a000a becomes a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80688 becomes 688)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80608 becomes 608)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80108 becomes 108)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80388 becomes 388)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (20482 becomes 482)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80b88 becomes b88)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80188 becomes 188)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80208 becomes 208)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80288 becomes 288)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a000a becomes a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100010 becomes 10)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100710 becomes 710)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100090 becomes 90)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (20402 becomes 402)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100790 becomes 790)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100490 becomes 490)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100310 becomes 310)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100590 becomes 590)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100610 becomes 610)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100690 becomes 690)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120912 becomes 912)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100590 becomes 590)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (20002 becomes 2)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (20082 becomes 82)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (20102 becomes 102)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (20182 becomes 182)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (20202 becomes 202)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (20282 becomes 282)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (20302 becomes 302)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (20382 becomes 382)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120012 becomes 12)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120092 becomes 92)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120112 becomes 112)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120192 becomes 192)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120212 becomes 212)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120292 becomes 292)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120312 becomes 312)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120392 becomes 392)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120412 becomes 412)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120492 becomes 492)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120592 becomes 592)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120612 becomes 612)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120512 becomes 512)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120692 becomes 692)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120712 becomes 712)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120792 becomes 792)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120812 becomes 812)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120892 becomes 892)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a019a becomes 19a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a021a becomes 21a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a029a becomes 29a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a031a becomes 31a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a039a becomes 39a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a041a becomes 41a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a049a becomes 49a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a051a becomes 51a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a059a becomes 59a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a061a becomes 61a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (120a92 becomes a92)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a089a becomes 89a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a091a becomes 91a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a099a becomes 99a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a028a becomes 28a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a030a becomes 30a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a038a becomes 38a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a040a becomes 40a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a048a becomes 48a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80b08 becomes b08)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100190 becomes 190)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100210 becomes 210)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80708 becomes 708)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80788 becomes 788)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80808 becomes 808)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80888 becomes 888)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100390 becomes 390)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100410 becomes 410)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100510 becomes 510)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a008a becomes 8a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a008a becomes 8a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a048a becomes 48a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (180018 becomes 18)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a010a becomes 10a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a010a becomes 10a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80408 becomes 408)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (80c88 becomes c88)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (180118 becomes 118)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (180198 becomes 198)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a009a becomes 9a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a028a becomes 28a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a030a becomes 30a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a038a becomes 38a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (a040a becomes 40a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100410 becomes 410)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (100510 becomes 510)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1a081a becomes 81a)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1b009b becomes 9b)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: cast truncates bits from constant value (1b011b becomes 11b)
+arch/x86/kvm/vmx/evmcs.h:80:30: warning: too many warnings
+  CC [M]  arch/x86/kvm/vmx/nested.o
+  LD [M]  arch/x86/kvm/kvm-intel.o
+  CHECK   arch/x86/kvm/svm.c
+./arch/x86/include/asm/paravirt.h:200:9: warning: cast truncates bits from constant value (100000000 becomes 0)
+./arch/x86/include/asm/paravirt.h:200:9: warning: cast truncates bits from constant value (100000000 becomes 0)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+arch/x86/kvm/svm.c:6791:60: warning: dereference of noderef expression
+arch/x86/kvm/svm.c:6814:14: warning: dereference of noderef expression
+arch/x86/kvm/svm.c:6820:59: warning: dereference of noderef expression
+arch/x86/kvm/svm.c:6834:14: warning: dereference of noderef expression
+arch/x86/kvm/svm.c:6859:70: warning: dereference of noderef expression
+  CC [M]  arch/x86/kvm/svm.o
+  CHECK   arch/x86/kvm/pmu_amd.c
+  CC [M]  arch/x86/kvm/pmu_amd.o
+  LD [M]  arch/x86/kvm/kvm-amd.o
+  CHECK   arch/x86/mm/init.c
+arch/x86/mm/init.c:738:9: warning: context imbalance in 'poking_init' - different lock contexts for basic block
+  CC      arch/x86/mm/init.o
+  CHECK   arch/x86/mm/init_64.c
+arch/x86/mm/init_64.c:107:5: warning: symbol 'force_personality32' was not declared. Should it be static?
+  CC      arch/x86/mm/init_64.o
+  CHECK   arch/x86/mm/fault.c
+  CC      arch/x86/mm/fault.o
+  CHECK   arch/x86/mm/ioremap.c
+arch/x86/mm/ioremap.c:716:17: warning: symbol 'early_memremap_pgprot_adjust' was not declared. Should it be static?
+  CC      arch/x86/mm/ioremap.o
+  CHECK   arch/x86/mm/extable.c
+  CC      arch/x86/mm/extable.o
+  CHECK   arch/x86/mm/pageattr.c
+arch/x86/mm/pageattr.c:307:6: warning: symbol 'arch_invalidate_pmem' was not declared. Should it be static?
+arch/x86/mm/pageattr.c:334:6: warning: symbol '__cpa_flush_tlb' was not declared. Should it be static?
+arch/x86/mm/pageattr.c:1927:5: warning: symbol 'set_memory_nonglobal' was not declared. Should it be static?
+arch/x86/mm/pageattr.c:1933:5: warning: symbol 'set_memory_global' was not declared. Should it be static?
+  CC      arch/x86/mm/pageattr.o
+  CHECK   arch/x86/mm/mmap.c
+arch/x86/mm/mmap.c:75:15: warning: symbol 'arch_mmap_rnd' was not declared. Should it be static?
+  CC      arch/x86/mm/mmap.o
+  CHECK   arch/x86/mm/pat.c
+  CC      arch/x86/mm/pat.o
+  CHECK   arch/x86/mm/pgtable.c
+  CC      arch/x86/mm/pgtable.o
+  CHECK   arch/x86/mm/physaddr.c
+  CC      arch/x86/mm/physaddr.o
+  CHECK   arch/x86/mm/setup_nx.c
+  CC      arch/x86/mm/setup_nx.o
+  CHECK   arch/x86/mm/tlb.c
+  CC      arch/x86/mm/tlb.o
+  CHECK   arch/x86/mm/cpu_entry_area.c
+  CC      arch/x86/mm/cpu_entry_area.o
+  CHECK   arch/x86/mm/maccess.c
+  CC      arch/x86/mm/maccess.o
+  CHECK   arch/x86/mm/pat_interval.c
+  CC      arch/x86/mm/pat_interval.o
+  CHECK   arch/x86/mm/hugetlbpage.c
+  CC      arch/x86/mm/hugetlbpage.o
+  CHECK   arch/x86/mm/dump_pagetables.c
+  CC      arch/x86/mm/dump_pagetables.o
+  CHECK   arch/x86/mm/kasan_init_64.c
+  CC      arch/x86/mm/kasan_init_64.o
+  CHECK   arch/x86/mm/kmmio.c
+arch/x86/mm/kmmio.c:230:5: warning: context imbalance in 'kmmio_handler' - different lock contexts for basic block
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'post_kmmio_handler' - unexpected unlock
+  CC      arch/x86/mm/kmmio.o
+  CHECK   arch/x86/mm/pf_in.c
+  CC      arch/x86/mm/pf_in.o
+  CHECK   arch/x86/mm/mmio-mod.c
+  CC      arch/x86/mm/mmio-mod.o
+  CHECK   arch/x86/mm/numa.c
+  CC      arch/x86/mm/numa.o
+  CHECK   arch/x86/mm/numa_64.c
+  CC      arch/x86/mm/numa_64.o
+  CHECK   arch/x86/mm/amdtopology.c
+  CC      arch/x86/mm/amdtopology.o
+  CHECK   arch/x86/mm/srat.c
+  CC      arch/x86/mm/srat.o
+  CHECK   arch/x86/mm/numa_emulation.c
+arch/x86/mm/numa_emulation.c:327:12: warning: symbol 'setup_emu2phys_nid' was not declared. Should it be static?
+  CC      arch/x86/mm/numa_emulation.o
+  CHECK   arch/x86/mm/mpx.c
+  CC      arch/x86/mm/mpx.o
+  CHECK   arch/x86/mm/pkeys.c
+  CC      arch/x86/mm/pkeys.o
+  CHECK   arch/x86/mm/kaslr.c
+  CC      arch/x86/mm/kaslr.o
+  CHECK   arch/x86/mm/pti.c
+  CC      arch/x86/mm/pti.o
+  CHECK   arch/x86/mm/mem_encrypt.c
+  CC      arch/x86/mm/mem_encrypt.o
+  CHECK   arch/x86/mm/mem_encrypt_identity.c
+  CC      arch/x86/mm/mem_encrypt_identity.o
+  AS      arch/x86/mm/mem_encrypt_boot.o
+  AR      arch/x86/mm/built-in.a
+  CHECK   arch/x86/mm/debug_pagetables.c
+  CC [M]  arch/x86/mm/debug_pagetables.o
+  CHECK   arch/x86/mm/testmmiotrace.c
+  CC [M]  arch/x86/mm/testmmiotrace.o
+  CHECK   arch/x86/net/bpf_jit_comp.c
+  CC      arch/x86/net/bpf_jit_comp.o
+  AR      arch/x86/net/built-in.a
+  CHECK   arch/x86/platform/atom/punit_atom_debug.c
+  CC [M]  arch/x86/platform/atom/punit_atom_debug.o
+  CHECK   arch/x86/platform/efi/quirks.c
+arch/x86/platform/efi/quirks.c:79:46: error: invalid initializer
+arch/x86/platform/efi/quirks.c:244:13: warning: symbol 'efi_arch_mem_reserve' was not declared. Should it be static?
+  CC      arch/x86/platform/efi/quirks.o
+  CHECK   arch/x86/platform/efi/efi.c
+arch/x86/platform/efi/efi.c:663:20: warning: incorrect type in assignment (different address spaces)
+arch/x86/platform/efi/efi.c:663:20:    expected void *[assigned] va
+arch/x86/platform/efi/efi.c:663:20:    got void [noderef] <asn:2> *
+  CC      arch/x86/platform/efi/efi.o
+  CHECK   arch/x86/platform/efi/efi_64.c
+  CC      arch/x86/platform/efi/efi_64.o
+  AS      arch/x86/platform/efi/efi_stub_64.o
+  AS      arch/x86/platform/efi/efi_thunk_64.o
+  AR      arch/x86/platform/efi/built-in.a
+  CHECK   arch/x86/platform/goldfish/goldfish.c
+  CC      arch/x86/platform/goldfish/goldfish.o
+  AR      arch/x86/platform/goldfish/built-in.a
+  CHECK   arch/x86/platform/intel/iosf_mbi.c
+  CC      arch/x86/platform/intel/iosf_mbi.o
+  AR      arch/x86/platform/intel/built-in.a
+  CHECK   arch/x86/platform/intel-mid/intel-mid.c
+  CC      arch/x86/platform/intel-mid/intel-mid.o
+  CHECK   arch/x86/platform/intel-mid/intel_mid_vrtc.c
+  CC      arch/x86/platform/intel-mid/intel_mid_vrtc.o
+  CHECK   arch/x86/platform/intel-mid/pwr.c
+arch/x86/platform/intel-mid/pwr.c:206:27: warning: restricted pci_power_t degrades to integer
+arch/x86/platform/intel-mid/pwr.c:206:36: warning: restricted pci_power_t degrades to integer
+arch/x86/platform/intel-mid/pwr.c:246:13: warning: restricted pci_power_t degrades to integer
+arch/x86/platform/intel-mid/pwr.c:246:21: warning: restricted pci_power_t degrades to integer
+arch/x86/platform/intel-mid/pwr.c:248:13: warning: restricted pci_power_t degrades to integer
+arch/x86/platform/intel-mid/pwr.c:248:21: warning: restricted pci_power_t degrades to integer
+  CC      arch/x86/platform/intel-mid/pwr.o
+  CHECK   arch/x86/platform/intel-mid/sfi.c
+  CC      arch/x86/platform/intel-mid/sfi.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_mrfld_pinctrl.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_mrfld_pinctrl.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_mrfld_sd.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_mrfld_sd.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_bcm43xx.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_msic.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_msic.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_msic_gpio.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_msic_gpio.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_msic_ocd.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_msic_ocd.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_msic_battery.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_msic_battery.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_msic_power_btn.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_msic_power_btn.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_msic_thermal.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_msic_thermal.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_mrfld_spidev.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_mrfld_spidev.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_emc1403.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_emc1403.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_lis331.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_lis331.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_mpu3050.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_mpu3050.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_bma023.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_bma023.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_tc35876x.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_max7315.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_max7315.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_pcal9555a.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_pcal9555a.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_tca6416.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_tca6416.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_gpio_keys.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_gpio_keys.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_mrfld_power_btn.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_mrfld_power_btn.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_mrfld_rtc.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_mrfld_rtc.o
+  CHECK   arch/x86/platform/intel-mid/device_libs/platform_mrfld_wdt.c
+  CC      arch/x86/platform/intel-mid/device_libs/platform_mrfld_wdt.o
+  AR      arch/x86/platform/intel-mid/device_libs/built-in.a
+  AR      arch/x86/platform/intel-mid/built-in.a
+  CHECK   arch/x86/platform/sfi/sfi.c
+  CC      arch/x86/platform/sfi/sfi.o
+  AR      arch/x86/platform/sfi/built-in.a
+  CHECK   arch/x86/platform/uv/tlb_uv.c
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:671:41: warning: incorrect type in argument 2 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:671:41:    expected void volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:671:41:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+arch/x86/platform/uv/tlb_uv.c:1275:6: warning: symbol 'uv_bau_message_interrupt' was not declared. Should it be static?
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:671:41: warning: incorrect type in argument 2 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:671:41:    expected void volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:671:41:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:671:41: warning: incorrect type in argument 2 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:671:41:    expected void volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:671:41:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+  CC      arch/x86/platform/uv/tlb_uv.o
+  CHECK   arch/x86/platform/uv/bios_uv.c
+arch/x86/platform/uv/bios_uv.c:196:19: warning: incorrect type in assignment (different address spaces)
+arch/x86/platform/uv/bios_uv.c:196:19:    expected struct uv_systab *[addressable] [toplevel] [assigned] uv_systab
+arch/x86/platform/uv/bios_uv.c:196:19:    got void [noderef] <asn:2> *
+arch/x86/platform/uv/bios_uv.c:199:25: warning: incorrect type in argument 1 (different address spaces)
+arch/x86/platform/uv/bios_uv.c:199:25:    expected void volatile [noderef] <asn:2> *addr
+arch/x86/platform/uv/bios_uv.c:199:25:    got struct uv_systab *[addressable] [toplevel] [assigned] uv_systab
+arch/x86/platform/uv/bios_uv.c:207:25: warning: incorrect type in argument 1 (different address spaces)
+arch/x86/platform/uv/bios_uv.c:207:25:    expected void volatile [noderef] <asn:2> *addr
+arch/x86/platform/uv/bios_uv.c:207:25:    got struct uv_systab *[addressable] [toplevel] [assigned] uv_systab
+arch/x86/platform/uv/bios_uv.c:208:27: warning: incorrect type in assignment (different address spaces)
+arch/x86/platform/uv/bios_uv.c:208:27:    expected struct uv_systab *[addressable] [toplevel] [assigned] uv_systab
+arch/x86/platform/uv/bios_uv.c:208:27:    got void [noderef] <asn:2> *
+  CC      arch/x86/platform/uv/bios_uv.o
+  CHECK   arch/x86/platform/uv/uv_irq.c
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+  CC      arch/x86/platform/uv/uv_irq.o
+  CHECK   arch/x86/platform/uv/uv_sysfs.c
+  CC      arch/x86/platform/uv/uv_sysfs.o
+  CHECK   arch/x86/platform/uv/uv_time.c
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+./arch/x86/include/asm/uv/uv_hub.h:631:16: warning: incorrect type in return expression (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    expected void volatile [noderef] <asn:2> *
+./arch/x86/include/asm/uv/uv_hub.h:631:16:    got void *
+  CC      arch/x86/platform/uv/uv_time.o
+  CHECK   arch/x86/platform/uv/uv_nmi.c
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:671:41: warning: incorrect type in argument 2 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:671:41:    expected void volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:671:41:    got unsigned long *
+arch/x86/platform/uv/uv_nmi.c:273:27: warning: incorrect type in argument 1 (different address spaces)
+arch/x86/platform/uv/uv_nmi.c:273:27:    expected void const volatile [noderef] <asn:2> *addr
+arch/x86/platform/uv/uv_nmi.c:273:27:    got int *addr
+arch/x86/platform/uv/uv_nmi.c:280:32: warning: incorrect type in argument 2 (different address spaces)
+arch/x86/platform/uv/uv_nmi.c:280:32:    expected void volatile [noderef] <asn:2> *addr
+arch/x86/platform/uv/uv_nmi.c:280:32:    got int *addr
+arch/x86/platform/uv/uv_nmi.c:283:30: warning: incorrect type in argument 2 (different address spaces)
+arch/x86/platform/uv/uv_nmi.c:283:30:    expected void volatile [noderef] <asn:2> *addr
+arch/x86/platform/uv/uv_nmi.c:283:30:    got int *addr
+arch/x86/platform/uv/uv_nmi.c:286:21: warning: incorrect type in argument 1 (different address spaces)
+arch/x86/platform/uv/uv_nmi.c:286:21:    expected void const volatile [noderef] <asn:2> *addr
+arch/x86/platform/uv/uv_nmi.c:286:21:    got int *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42: warning: incorrect type in argument 1 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    expected void const volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:666:42:    got unsigned long *
+./arch/x86/include/asm/uv/uv_hub.h:671:41: warning: incorrect type in argument 2 (different address spaces)
+./arch/x86/include/asm/uv/uv_hub.h:671:41:    expected void volatile [noderef] <asn:2> *addr
+./arch/x86/include/asm/uv/uv_hub.h:671:41:    got unsigned long *
+arch/x86/platform/uv/uv_nmi.c:528:9: warning: context imbalance in 'uv_check_nmi' - different lock contexts for basic block
+arch/x86/platform/uv/uv_nmi.c:546:17: warning: context imbalance in 'uv_handle_nmi' - unexpected unlock
+  CC      arch/x86/platform/uv/uv_nmi.o
+  AR      arch/x86/platform/uv/built-in.a
+  AR      arch/x86/platform/built-in.a
+  CHECK   arch/x86/platform/pvh/enlighten.c
+arch/x86/platform/pvh/enlighten.c:22:20: warning: symbol 'pvh_bootparams' was not declared. Should it be static?
+arch/x86/platform/pvh/enlighten.c:25:14: warning: symbol 'pvh_start_info_sz' was not declared. Should it be static?
+arch/x86/platform/pvh/enlighten.c:39:20: warning: symbol 'mem_map_via_hcall' was not declared. Should it be static?
+arch/x86/platform/pvh/enlighten.c:104:20: warning: symbol 'xen_pvh_init' was not declared. Should it be static?
+arch/x86/platform/pvh/enlighten.c:120:13: warning: symbol 'xen_prepare_pvh' was not declared. Should it be static?
+  CC      arch/x86/platform/pvh/enlighten.o
+  AS      arch/x86/platform/pvh/head.o
+  AR      arch/x86/platform/pvh/built-in.a
+  CHECK   arch/x86/purgatory/purgatory.c
+arch/x86/purgatory/purgatory.c:57:6: warning: symbol 'warn' was not declared. Should it be static?
+  CC      arch/x86/purgatory/purgatory.o
+  CC      arch/x86/purgatory/sha256.o
+  CC      arch/x86/purgatory/string.o
+  LD      arch/x86/purgatory/purgatory.ro
+  BIN2C   arch/x86/purgatory/kexec-purgatory.c
+  CHECK   arch/x86/purgatory/kexec-purgatory.c
+arch/x86/purgatory/kexec-purgatory.c:1580:9: warning: trying to concatenate 25240-character string (8191 bytes max)
+arch/x86/purgatory/kexec-purgatory.c:1:12: warning: symbol 'kexec_purgatory' was not declared. Should it be static?
+arch/x86/purgatory/kexec-purgatory.c:1584:14: warning: symbol 'kexec_purgatory_size' was not declared. Should it be static?
+  CC      arch/x86/purgatory/kexec-purgatory.o
+  AR      arch/x86/purgatory/built-in.a
+  CHECK   arch/x86/realmode/init.c
+  CC      arch/x86/realmode/init.o
+  AS      arch/x86/realmode/rm/header.o
+  AS      arch/x86/realmode/rm/trampoline_64.o
+  AS      arch/x86/realmode/rm/reboot.o
+  AS      arch/x86/realmode/rm/wakeup_asm.o
+  CHECK   arch/x86/realmode/rm/wakemain.c
+  CC      arch/x86/realmode/rm/wakemain.o
+  CHECK   arch/x86/realmode/rm/video-mode.c
+  CC      arch/x86/realmode/rm/video-mode.o
+  CHECK   arch/x86/realmode/rm/regs.c
+  CC      arch/x86/realmode/rm/regs.o
+  CHECK   arch/x86/realmode/rm/video-vga.c
+  CC      arch/x86/realmode/rm/video-vga.o
+  CHECK   arch/x86/realmode/rm/video-vesa.c
+  CC      arch/x86/realmode/rm/video-vesa.o
+  CHECK   arch/x86/realmode/rm/video-bios.c
+  CC      arch/x86/realmode/rm/video-bios.o
+  PASYMS  arch/x86/realmode/rm/pasyms.h
+  LDS     arch/x86/realmode/rm/realmode.lds
+  LD      arch/x86/realmode/rm/realmode.elf
+  RELOCS  arch/x86/realmode/rm/realmode.relocs
+  OBJCOPY arch/x86/realmode/rm/realmode.bin
+  AS      arch/x86/realmode/rmpiggy.o
+  AR      arch/x86/realmode/built-in.a
+  CHECK   arch/x86/xen/enlighten.c
+arch/x86/xen/enlighten.c:67:19: warning: symbol 'xen_have_vector_callback' was not declared. Should it be static?
+  CC      arch/x86/xen/enlighten.o
+  CHECK   arch/x86/xen/mmu.c
+  CC      arch/x86/xen/mmu.o
+  CHECK   arch/x86/xen/time.c
+  CC      arch/x86/xen/time.o
+  CHECK   arch/x86/xen/grant-table.c
+  CC      arch/x86/xen/grant-table.o
+  CHECK   arch/x86/xen/suspend.c
+  CC      arch/x86/xen/suspend.o
+  CHECK   arch/x86/xen/enlighten_hvm.c
+  CC      arch/x86/xen/enlighten_hvm.o
+  CHECK   arch/x86/xen/mmu_hvm.c
+  CC      arch/x86/xen/mmu_hvm.o
+  CHECK   arch/x86/xen/suspend_hvm.c
+  CC      arch/x86/xen/suspend_hvm.o
+  CHECK   arch/x86/xen/platform-pci-unplug.c
+  CC      arch/x86/xen/platform-pci-unplug.o
+  CHECK   arch/x86/xen/setup.c
+arch/x86/xen/setup.c:988:13: warning: symbol 'xen_pvmmu_arch_setup' was not declared. Should it be static?
+  CC      arch/x86/xen/setup.o
+  CHECK   arch/x86/xen/apic.c
+  CC      arch/x86/xen/apic.o
+  CHECK   arch/x86/xen/pmu.c
+  CC      arch/x86/xen/pmu.o
+  CHECK   arch/x86/xen/suspend_pv.c
+  CC      arch/x86/xen/suspend_pv.o
+  CHECK   arch/x86/xen/p2m.c
+  CC      arch/x86/xen/p2m.o
+  CHECK   arch/x86/xen/enlighten_pv.c
+  CC      arch/x86/xen/enlighten_pv.o
+  CHECK   arch/x86/xen/mmu_pv.c
+arch/x86/xen/mmu_pv.c:697:19: warning: context imbalance in 'xen_pte_lock' - wrong count at exit
+arch/x86/xen/mmu_pv.c:709:13: warning: context imbalance in 'xen_pte_unlock' - unexpected unlock
+  CC      arch/x86/xen/mmu_pv.o
+  CHECK   arch/x86/xen/irq.c
+arch/x86/xen/irq.c:22:6: warning: symbol 'xen_force_evtchn_callback' was not declared. Should it be static?
+  CC      arch/x86/xen/irq.o
+  CHECK   arch/x86/xen/multicalls.c
+  CC      arch/x86/xen/multicalls.o
+  AS      arch/x86/xen/xen-asm.o
+  AS      arch/x86/xen/xen-asm_64.o
+  CHECK   arch/x86/xen/enlighten_pvh.c
+arch/x86/xen/enlighten_pvh.c:26:13: warning: symbol 'xen_pvh_init' was not declared. Should it be static?
+arch/x86/xen/enlighten_pvh.c:42:13: warning: symbol 'mem_map_via_hcall' was not declared. Should it be static?
+  CC      arch/x86/xen/enlighten_pvh.o
+  CHECK   arch/x86/xen/trace.c
+  CC      arch/x86/xen/trace.o
+  CHECK   arch/x86/xen/smp.c
+  CC      arch/x86/xen/smp.o
+  CHECK   arch/x86/xen/smp_pv.c
+  CC      arch/x86/xen/smp_pv.o
+  CHECK   arch/x86/xen/smp_hvm.c
+  CC      arch/x86/xen/smp_hvm.o
+  CHECK   arch/x86/xen/spinlock.c
+  CC      arch/x86/xen/spinlock.o
+  CHECK   arch/x86/xen/debugfs.c
+  CC      arch/x86/xen/debugfs.o
+  CHECK   arch/x86/xen/vga.c
+  CC      arch/x86/xen/vga.o
+  CHECK   arch/x86/xen/pci-swiotlb-xen.c
+  CC      arch/x86/xen/pci-swiotlb-xen.o
+  CHECK   arch/x86/xen/efi.c
+arch/x86/xen/efi.c:109:35: warning: incorrect type in argument 1 (different type sizes)
+arch/x86/xen/efi.c:109:35:    expected unsigned short [usertype] *name
+arch/x86/xen/efi.c:109:35:    got char *
+arch/x86/xen/efi.c:119:35: warning: incorrect type in argument 1 (different type sizes)
+arch/x86/xen/efi.c:119:35:    expected unsigned short [usertype] *name
+arch/x86/xen/efi.c:119:35:    got char *
+arch/x86/xen/efi.c:130:35: warning: incorrect type in argument 1 (different type sizes)
+arch/x86/xen/efi.c:130:35:    expected unsigned short [usertype] *name
+arch/x86/xen/efi.c:130:35:    got char *
+arch/x86/xen/efi.c:149:13: warning: symbol 'xen_efi_init' was not declared. Should it be static?
+  CC      arch/x86/xen/efi.o
+  AR      arch/x86/xen/built-in.a
+  AR      arch/x86/built-in.a
+  CHECK   kernel/fork.c
+kernel/fork.c:992:19: warning: incorrect type in assignment (different address spaces)
+kernel/fork.c:992:19:    expected struct task_struct [noderef] <asn:4> *owner
+kernel/fork.c:992:19:    got struct task_struct *p
+kernel/fork.c:1508:9: error: incompatible types in comparison expression (different address spaces):
+kernel/fork.c:1508:9:    struct sighand_struct [noderef] <asn:4> *
+kernel/fork.c:1508:9:    struct sighand_struct *
+kernel/fork.c:2198:32: warning: incorrect type in assignment (different address spaces)
+kernel/fork.c:2198:32:    expected struct task_struct [noderef] <asn:4> *real_parent
+kernel/fork.c:2198:32:    got struct task_struct *
+./include/linux/ptrace.h:218:45: warning: incorrect type in argument 2 (different address spaces)
+./include/linux/ptrace.h:218:45:    expected struct task_struct *new_parent
+./include/linux/ptrace.h:218:45:    got struct task_struct [noderef] <asn:4> *parent
+./include/linux/ptrace.h:218:62: warning: incorrect type in argument 3 (different address spaces)
+./include/linux/ptrace.h:218:62:    expected struct cred const *ptracer_cred
+./include/linux/ptrace.h:218:62:    got struct cred const [noderef] <asn:4> *ptracer_cred
+kernel/fork.c:2253:54: warning: incorrect type in argument 2 (different address spaces)
+kernel/fork.c:2253:54:    expected struct list_head *head
+kernel/fork.c:2253:54:    got struct list_head [noderef] <asn:4> *
+kernel/fork.c:984:23: error: incompatible types in comparison expression (different address spaces):
+kernel/fork.c:984:23:    struct task_struct [noderef] <asn:4> *
+kernel/fork.c:984:23:    struct task_struct *
+kernel/fork.c:2744:24: warning: incorrect type in assignment (different address spaces)
+kernel/fork.c:2744:24:    expected struct task_struct *[assigned] parent
+kernel/fork.c:2744:24:    got struct task_struct [noderef] <asn:4> *real_parent
+kernel/fork.c:1933:27: warning: dereference of noderef expression
+kernel/fork.c:1935:22: warning: dereference of noderef expression
+kernel/fork.c:2251:59: warning: dereference of noderef expression
+kernel/fork.c:2252:59: warning: dereference of noderef expression
+kernel/fork.c:2339:22: warning: dereference of noderef expression
+  CC      kernel/fork.o
+  CHECK   kernel/exec_domain.c
+  CC      kernel/exec_domain.o
+  CHECK   kernel/panic.c
+kernel/panic.c:75:13: warning: symbol 'panic_smp_self_stop' was not declared. Should it be static?
+kernel/panic.c:85:13: warning: symbol 'nmi_panic_self_stop' was not declared. Should it be static?
+kernel/panic.c:96:13: warning: symbol 'crash_smp_send_stop' was not declared. Should it be static?
+kernel/panic.c:167:6: error: symbol 'panic' redeclared with different type (originally declared at ./include/linux/kernel.h:322) - different modifiers
+  CC      kernel/panic.o
+  CHECK   kernel/cpu.c
+kernel/cpu.c:828:9: warning: context imbalance in 'clear_tasks_mm_cpumask' - different lock contexts for basic block
+  CC      kernel/cpu.o
+  CHECK   kernel/exit.c
+kernel/exit.c:100:19: error: incompatible types in comparison expression (different address spaces):
+kernel/exit.c:100:19:    struct sighand_struct [noderef] <asn:4> *
+kernel/exit.c:100:19:    struct sighand_struct *
+kernel/exit.c:278:37: warning: incorrect type in argument 1 (different address spaces)
+kernel/exit.c:278:37:    expected struct task_struct *tsk
+kernel/exit.c:278:37:    got struct task_struct [noderef] <asn:4> *real_parent
+kernel/exit.c:281:32: warning: incorrect type in argument 1 (different address spaces)
+kernel/exit.c:281:32:    expected struct task_struct *task
+kernel/exit.c:281:32:    got struct task_struct [noderef] <asn:4> *real_parent
+kernel/exit.c:282:35: warning: incorrect type in argument 1 (different address spaces)
+kernel/exit.c:282:35:    expected struct task_struct *task
+kernel/exit.c:282:35:    got struct task_struct [noderef] <asn:4> *real_parent
+kernel/exit.c:327:24: warning: incorrect type in assignment (different address spaces)
+kernel/exit.c:327:24:    expected struct task_struct *parent
+kernel/exit.c:327:24:    got struct task_struct [noderef] <asn:4> *real_parent
+kernel/exit.c:356:23: error: incompatible types in comparison expression (different address spaces):
+kernel/exit.c:356:23:    struct task_struct [noderef] <asn:4> *
+kernel/exit.c:356:23:    struct task_struct *
+kernel/exit.c:380:9: error: incompatible types in comparison expression (different address spaces):
+kernel/exit.c:380:9:    struct list_head *
+kernel/exit.c:380:9:    struct list_head [noderef] <asn:4> *
+kernel/exit.c:562:29: warning: incorrect type in assignment (different address spaces)
+kernel/exit.c:562:29:    expected struct task_struct *reaper
+kernel/exit.c:562:29:    got struct task_struct [noderef] <asn:4> *real_parent
+kernel/exit.c:564:29: warning: incorrect type in assignment (different address spaces)
+kernel/exit.c:564:29:    expected struct task_struct *reaper
+kernel/exit.c:564:29:    got struct task_struct [noderef] <asn:4> *real_parent
+kernel/exit.c:626:40: warning: incorrect type in assignment (different address spaces)
+kernel/exit.c:626:40:    expected struct task_struct [noderef] <asn:4> *real_parent
+kernel/exit.c:626:40:    got struct task_struct *[assigned] reaper
+kernel/exit.c:627:25: error: incompatible types in comparison expression (different address spaces):
+kernel/exit.c:627:25:    struct task_struct [noderef] <asn:4> *
+kernel/exit.c:627:25:    struct task_struct *
+./include/linux/ptrace.h:99:40: warning: incorrect type in argument 1 (different address spaces)
+./include/linux/ptrace.h:99:40:    expected struct task_struct *p1
+./include/linux/ptrace.h:99:40:    got struct task_struct [noderef] <asn:4> *real_parent
+./include/linux/ptrace.h:99:60: warning: incorrect type in argument 2 (different address spaces)
+./include/linux/ptrace.h:99:60:    expected struct task_struct *p2
+./include/linux/ptrace.h:99:60:    got struct task_struct [noderef] <asn:4> *parent
+kernel/exit.c:715:17: error: symbol 'do_exit' redeclared with different type (originally declared at ./include/linux/kernel.h:328) - different modifiers
+kernel/exit.c:853:6: error: symbol 'complete_and_exit' redeclared with different type (originally declared at ./include/linux/kernel.h:329) - different modifiers
+./include/linux/ptrace.h:99:40: warning: incorrect type in argument 1 (different address spaces)
+./include/linux/ptrace.h:99:40:    expected struct task_struct *p1
+./include/linux/ptrace.h:99:40:    got struct task_struct [noderef] <asn:4> *real_parent
+./include/linux/ptrace.h:99:60: warning: incorrect type in argument 2 (different address spaces)
+./include/linux/ptrace.h:99:60:    expected struct task_struct *p2
+./include/linux/ptrace.h:99:60:    got struct task_struct [noderef] <asn:4> *parent
+./include/linux/ptrace.h:99:40: warning: incorrect type in argument 1 (different address spaces)
+./include/linux/ptrace.h:99:40:    expected struct task_struct *p1
+./include/linux/ptrace.h:99:40:    got struct task_struct [noderef] <asn:4> *real_parent
+./include/linux/ptrace.h:99:60: warning: incorrect type in argument 2 (different address spaces)
+./include/linux/ptrace.h:99:60:    expected struct task_struct *p2
+./include/linux/ptrace.h:99:60:    got struct task_struct [noderef] <asn:4> *parent
+kernel/exit.c:1403:59: error: incompatible types in comparison expression (different base types):
+kernel/exit.c:1403:59:    void *
+kernel/exit.c:1403:59:    struct task_struct [noderef] <asn:4> *
+kernel/exit.c:1706:13: warning: symbol 'abort' was not declared. Should it be static?
+kernel/exit.c:380:9: warning: dereference of noderef expression
+./include/linux/sched/task.h:111:34: warning: context imbalance in 'wait_task_zombie' - unexpected unlock
+./include/linux/sched/task.h:111:34: warning: context imbalance in 'wait_task_stopped' - unexpected unlock
+./include/linux/sched/task.h:111:34: warning: context imbalance in 'wait_task_continued' - unexpected unlock
+kernel/exit.c:1464:9: warning: context imbalance in 'do_wait' - wrong count at exit
+  CC      kernel/exit.o
+  CHECK   kernel/softirq.c
+  CC      kernel/softirq.o
+  CHECK   kernel/resource.c
+  CC      kernel/resource.o
+  CHECK   kernel/sysctl.c
+  CC      kernel/sysctl.o
+  CHECK   kernel/sysctl_binary.c
+  CC      kernel/sysctl_binary.o
+  CHECK   kernel/capability.c
+  CC      kernel/capability.o
+  CHECK   kernel/ptrace.c
+kernel/ptrace.c:53:22: error: incompatible types in comparison expression (different address spaces):
+kernel/ptrace.c:53:22:    struct task_struct *
+kernel/ptrace.c:53:22:    struct task_struct [noderef] <asn:4> *
+kernel/ptrace.c:72:23: warning: incorrect type in assignment (different address spaces)
+kernel/ptrace.c:72:23:    expected struct task_struct [noderef] <asn:4> *parent
+kernel/ptrace.c:72:23:    got struct task_struct *new_parent
+kernel/ptrace.c:73:29: warning: incorrect type in assignment (different address spaces)
+kernel/ptrace.c:73:29:    expected struct cred const [noderef] <asn:4> *ptracer_cred
+kernel/ptrace.c:73:29:    got struct cred const *
+kernel/ptrace.c:127:18: warning: incorrect type in assignment (different address spaces)
+kernel/ptrace.c:127:18:    expected struct cred const *old_cred
+kernel/ptrace.c:127:18:    got struct cred const [noderef] <asn:4> *ptracer_cred
+kernel/ptrace.c:196:9: error: incompatible types in comparison expression (different address spaces):
+kernel/ptrace.c:196:9:    struct task_struct [noderef] <asn:4> *
+kernel/ptrace.c:196:9:    struct task_struct *
+kernel/ptrace.c:241:44: error: incompatible types in comparison expression (different address spaces):
+kernel/ptrace.c:241:44:    struct task_struct [noderef] <asn:4> *
+kernel/ptrace.c:241:44:    struct task_struct *
+kernel/ptrace.c:475:54: warning: incorrect type in argument 1 (different address spaces)
+kernel/ptrace.c:475:54:    expected struct task_struct *parent
+kernel/ptrace.c:475:54:    got struct task_struct [noderef] <asn:4> *parent
+kernel/ptrace.c:483:53: warning: incorrect type in argument 2 (different address spaces)
+kernel/ptrace.c:483:53:    expected struct task_struct *new_parent
+kernel/ptrace.c:483:53:    got struct task_struct [noderef] <asn:4> *real_parent
+kernel/ptrace.c:531:41: warning: incorrect type in argument 1 (different address spaces)
+kernel/ptrace.c:531:41:    expected struct task_struct *p1
+kernel/ptrace.c:531:41:    got struct task_struct [noderef] <asn:4> *real_parent
+kernel/ptrace.c:481:38: warning: dereference of noderef expression
+kernel/ptrace.c:682:9: warning: context imbalance in 'ptrace_getsiginfo' - different lock contexts for basic block
+kernel/ptrace.c:698:9: warning: context imbalance in 'ptrace_setsiginfo' - different lock contexts for basic block
+kernel/ptrace.c:854:9: warning: context imbalance in 'ptrace_resume' - different lock contexts for basic block
+  CC      kernel/ptrace.o
+  CHECK   kernel/user.c
+kernel/user.c:85:19: warning: symbol 'uidhash_table' was not declared. Should it be static?
+kernel/user.c:172:17: warning: context imbalance in 'free_uid' - unexpected unlock
+  CC      kernel/user.o
+  CHECK   kernel/signal.c
+kernel/signal.c:1370:27: error: incompatible types in comparison expression (different address spaces):
+kernel/signal.c:1370:27:    struct sighand_struct [noderef] <asn:4> *
+kernel/signal.c:1370:27:    struct sighand_struct *
+kernel/signal.c:1948:65: warning: incorrect type in argument 1 (different address spaces)
+kernel/signal.c:1948:65:    expected struct task_struct *tsk
+kernel/signal.c:1948:65:    got struct task_struct [noderef] <asn:4> *parent
+kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
+kernel/signal.c:1949:40:    expected void const volatile *p
+kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
+kernel/signal.c:1949:40: warning: incorrect type in argument 1 (different address spaces)
+kernel/signal.c:1949:40:    expected void const volatile *p
+kernel/signal.c:1949:40:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
+kernel/signal.c:1992:54: warning: incorrect type in argument 3 (different address spaces)
+kernel/signal.c:1992:54:    expected struct task_struct *p
+kernel/signal.c:1992:54:    got struct task_struct [noderef] <asn:4> *parent
+kernel/signal.c:1993:34: warning: incorrect type in argument 2 (different address spaces)
+kernel/signal.c:1993:34:    expected struct task_struct *parent
+kernel/signal.c:1993:34:    got struct task_struct [noderef] <asn:4> *parent
+kernel/signal.c:2022:24: warning: incorrect type in assignment (different address spaces)
+kernel/signal.c:2022:24:    expected struct task_struct *parent
+kernel/signal.c:2022:24:    got struct task_struct [noderef] <asn:4> *parent
+kernel/signal.c:2025:24: warning: incorrect type in assignment (different address spaces)
+kernel/signal.c:2025:24:    expected struct task_struct *parent
+kernel/signal.c:2025:24:    got struct task_struct [noderef] <asn:4> *real_parent
+./include/linux/ptrace.h:99:40: warning: incorrect type in argument 1 (different address spaces)
+./include/linux/ptrace.h:99:40:    expected struct task_struct *p1
+./include/linux/ptrace.h:99:40:    got struct task_struct [noderef] <asn:4> *real_parent
+./include/linux/ptrace.h:99:60: warning: incorrect type in argument 2 (different address spaces)
+./include/linux/ptrace.h:99:60:    expected struct task_struct *p2
+./include/linux/ptrace.h:99:60:    got struct task_struct [noderef] <asn:4> *parent
+kernel/signal.c:2506:52: warning: incorrect type in argument 1 (different address spaces)
+kernel/signal.c:2506:52:    expected struct task_struct *tsk
+kernel/signal.c:2506:52:    got struct task_struct [noderef] <asn:4> *parent
+kernel/signal.c:2508:49: warning: incorrect type in argument 1 (different address spaces)
+kernel/signal.c:2508:49:    expected void const volatile *p
+kernel/signal.c:2508:49:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
+kernel/signal.c:2508:49: warning: incorrect type in argument 1 (different address spaces)
+kernel/signal.c:2508:49:    expected void const volatile *p
+kernel/signal.c:2508:49:    got struct cred const [noderef] <asn:4> *[noderef] <asn:4> *
+./include/linux/ptrace.h:99:40: warning: incorrect type in argument 1 (different address spaces)
+./include/linux/ptrace.h:99:40:    expected struct task_struct *p1
+./include/linux/ptrace.h:99:40:    got struct task_struct [noderef] <asn:4> *real_parent
+./include/linux/ptrace.h:99:60: warning: incorrect type in argument 2 (different address spaces)
+./include/linux/ptrace.h:99:60:    expected struct task_struct *p2
+./include/linux/ptrace.h:99:60:    got struct task_struct [noderef] <asn:4> *parent
+kernel/signal.c:3676:46: warning: incorrect type in argument 2 (different address spaces)
+kernel/signal.c:3676:46:    expected struct siginfo const [noderef] [usertype] <asn:1> *from
+kernel/signal.c:3676:46:    got struct siginfo [usertype] *info
+kernel/signal.c:3736:58: warning: incorrect type in argument 2 (different address spaces)
+kernel/signal.c:3736:58:    expected struct siginfo [usertype] *info
+kernel/signal.c:3736:58:    got struct siginfo [noderef] [usertype] <asn:1> *info
+kernel/signal.c:4585:6: warning: symbol 'kdb_send_sig' was not declared. Should it be static?
+kernel/signal.c:1289:9: warning: context imbalance in 'do_send_sig_info' - different lock contexts for basic block
+./include/linux/rcupdate.h:667:9: warning: context imbalance in '__lock_task_sighand' - different lock contexts for basic block
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'send_sigqueue' - wrong count at exit
+kernel/signal.c:1929:47: warning: dereference of noderef expression
+kernel/signal.c:1949:40: warning: dereference of noderef expression
+kernel/signal.c:1949:40: warning: dereference of noderef expression
+kernel/signal.c:1967:19: warning: dereference of noderef expression
+kernel/signal.c:2088:13: warning: dereference of noderef expression
+kernel/signal.c:2299:13: warning: context imbalance in 'do_signal_stop' - different lock contexts for basic block
+kernel/signal.c:2508:49: warning: dereference of noderef expression
+kernel/signal.c:2508:49: warning: dereference of noderef expression
+kernel/signal.c:2591:69: warning: context imbalance in 'get_signal' - unexpected unlock
+  CC      kernel/signal.o
+  CHECK   kernel/sys.c
+kernel/sys.c:1035:32: warning: incorrect type in argument 1 (different address spaces)
+kernel/sys.c:1035:32:    expected struct task_struct *p1
+kernel/sys.c:1035:32:    got struct task_struct [noderef] <asn:4> *real_parent
+kernel/sys.c:1862:19: warning: incorrect type in initializer (different address spaces)
+kernel/sys.c:1862:19:    expected struct file [noderef] <asn:4> *__ret
+kernel/sys.c:1862:19:    got struct file *[assigned] file
+kernel/sys.c:1862:17: warning: incorrect type in assignment (different address spaces)
+kernel/sys.c:1862:17:    expected struct file *old_exe
+kernel/sys.c:1862:17:    got struct file [noderef] <asn:4> *[assigned] __ret
+kernel/sys.c:2224:16: warning: incorrect type in argument 1 (different address spaces)
+kernel/sys.c:2224:16:    expected void const volatile [noderef] <asn:1> *
+kernel/sys.c:2224:16:    got int [noderef] <asn:1> **tid_addr
+  CC      kernel/sys.o
+  CHECK   kernel/umh.c
+  CC      kernel/umh.o
+  CHECK   kernel/workqueue.c
+  CC      kernel/workqueue.o
+  CHECK   kernel/pid.c
+kernel/pid.c:60:5: warning: symbol 'pid_max' was not declared. Should it be static?
+kernel/pid.c:64:5: warning: symbol 'pid_max_min' was not declared. Should it be static?
+kernel/pid.c:65:5: warning: symbol 'pid_max_max' was not declared. Should it be static?
+kernel/pid.c:417:23: error: incompatible types in comparison expression (different address spaces):
+kernel/pid.c:417:23:    struct pid [noderef] <asn:4> *
+kernel/pid.c:417:23:    struct pid *
+kernel/pid.c:476:32: error: incompatible types in comparison expression (different address spaces):
+kernel/pid.c:476:32:    struct pid [noderef] <asn:4> *
+kernel/pid.c:476:32:    struct pid *
+  CC      kernel/pid.o
+  CHECK   kernel/task_work.c
+  CC      kernel/task_work.o
+  CHECK   kernel/extable.c
+  CC      kernel/extable.o
+  CHECK   kernel/params.c
+  CC      kernel/params.o
+  CHECK   kernel/kthread.c
+  CC      kernel/kthread.o
+  CHECK   kernel/sys_ni.c
+kernel/sys_ni.c:39:1: warning: symbol '__x64_sys_io_setup' was not declared. Should it be static?
+kernel/sys_ni.c:39:1: warning: symbol '__ia32_sys_io_setup' was not declared. Should it be static?
+kernel/sys_ni.c:41:1: warning: symbol '__x64_sys_io_destroy' was not declared. Should it be static?
+kernel/sys_ni.c:41:1: warning: symbol '__ia32_sys_io_destroy' was not declared. Should it be static?
+kernel/sys_ni.c:42:1: warning: symbol '__x64_sys_io_submit' was not declared. Should it be static?
+kernel/sys_ni.c:42:1: warning: symbol '__ia32_sys_io_submit' was not declared. Should it be static?
+kernel/sys_ni.c:44:1: warning: symbol '__x64_sys_io_cancel' was not declared. Should it be static?
+kernel/sys_ni.c:44:1: warning: symbol '__ia32_sys_io_cancel' was not declared. Should it be static?
+kernel/sys_ni.c:45:1: warning: symbol '__x64_sys_io_getevents_time32' was not declared. Should it be static?
+kernel/sys_ni.c:45:1: warning: symbol '__ia32_sys_io_getevents_time32' was not declared. Should it be static?
+kernel/sys_ni.c:46:1: warning: symbol '__x64_sys_io_getevents' was not declared. Should it be static?
+kernel/sys_ni.c:46:1: warning: symbol '__ia32_sys_io_getevents' was not declared. Should it be static?
+kernel/sys_ni.c:47:1: warning: symbol '__x64_sys_io_pgetevents_time32' was not declared. Should it be static?
+kernel/sys_ni.c:47:1: warning: symbol '__ia32_sys_io_pgetevents_time32' was not declared. Should it be static?
+kernel/sys_ni.c:48:1: warning: symbol '__x64_sys_io_pgetevents' was not declared. Should it be static?
+kernel/sys_ni.c:48:1: warning: symbol '__ia32_sys_io_pgetevents' was not declared. Should it be static?
+kernel/sys_ni.c:51:1: warning: symbol '__x64_sys_io_uring_setup' was not declared. Should it be static?
+kernel/sys_ni.c:51:1: warning: symbol '__ia32_sys_io_uring_setup' was not declared. Should it be static?
+kernel/sys_ni.c:52:1: warning: symbol '__x64_sys_io_uring_enter' was not declared. Should it be static?
+kernel/sys_ni.c:52:1: warning: symbol '__ia32_sys_io_uring_enter' was not declared. Should it be static?
+kernel/sys_ni.c:53:1: warning: symbol '__x64_sys_io_uring_register' was not declared. Should it be static?
+kernel/sys_ni.c:53:1: warning: symbol '__ia32_sys_io_uring_register' was not declared. Should it be static?
+kernel/sys_ni.c:60:1: warning: symbol '__x64_sys_lookup_dcookie' was not declared. Should it be static?
+kernel/sys_ni.c:60:1: warning: symbol '__ia32_sys_lookup_dcookie' was not declared. Should it be static?
+kernel/sys_ni.c:64:1: warning: symbol '__x64_sys_eventfd2' was not declared. Should it be static?
+kernel/sys_ni.c:64:1: warning: symbol '__ia32_sys_eventfd2' was not declared. Should it be static?
+kernel/sys_ni.c:67:1: warning: symbol '__x64_sys_epoll_create1' was not declared. Should it be static?
+kernel/sys_ni.c:67:1: warning: symbol '__ia32_sys_epoll_create1' was not declared. Should it be static?
+kernel/sys_ni.c:68:1: warning: symbol '__x64_sys_epoll_ctl' was not declared. Should it be static?
+kernel/sys_ni.c:68:1: warning: symbol '__ia32_sys_epoll_ctl' was not declared. Should it be static?
+kernel/sys_ni.c:69:1: warning: symbol '__x64_sys_epoll_pwait' was not declared. Should it be static?
+kernel/sys_ni.c:69:1: warning: symbol '__ia32_sys_epoll_pwait' was not declared. Should it be static?
+kernel/sys_ni.c:75:1: warning: symbol '__x64_sys_inotify_init1' was not declared. Should it be static?
+kernel/sys_ni.c:75:1: warning: symbol '__ia32_sys_inotify_init1' was not declared. Should it be static?
+kernel/sys_ni.c:76:1: warning: symbol '__x64_sys_inotify_add_watch' was not declared. Should it be static?
+kernel/sys_ni.c:76:1: warning: symbol '__ia32_sys_inotify_add_watch' was not declared. Should it be static?
+kernel/sys_ni.c:77:1: warning: symbol '__x64_sys_inotify_rm_watch' was not declared. Should it be static?
+kernel/sys_ni.c:77:1: warning: symbol '__ia32_sys_inotify_rm_watch' was not declared. Should it be static?
+kernel/sys_ni.c:82:1: warning: symbol '__x64_sys_ioprio_set' was not declared. Should it be static?
+kernel/sys_ni.c:82:1: warning: symbol '__ia32_sys_ioprio_set' was not declared. Should it be static?
+kernel/sys_ni.c:83:1: warning: symbol '__x64_sys_ioprio_get' was not declared. Should it be static?
+kernel/sys_ni.c:83:1: warning: symbol '__ia32_sys_ioprio_get' was not declared. Should it be static?
+kernel/sys_ni.c:86:1: warning: symbol '__x64_sys_flock' was not declared. Should it be static?
+kernel/sys_ni.c:86:1: warning: symbol '__ia32_sys_flock' was not declared. Should it be static?
+kernel/sys_ni.c:99:1: warning: symbol '__x64_sys_quotactl' was not declared. Should it be static?
+kernel/sys_ni.c:99:1: warning: symbol '__ia32_sys_quotactl' was not declared. Should it be static?
+kernel/sys_ni.c:110:1: warning: symbol '__x64_sys_signalfd4' was not declared. Should it be static?
+kernel/sys_ni.c:110:1: warning: symbol '__ia32_sys_signalfd4' was not declared. Should it be static?
+kernel/sys_ni.c:120:1: warning: symbol '__x64_sys_timerfd_create' was not declared. Should it be static?
+kernel/sys_ni.c:120:1: warning: symbol '__ia32_sys_timerfd_create' was not declared. Should it be static?
+kernel/sys_ni.c:121:1: warning: symbol '__x64_sys_timerfd_settime' was not declared. Should it be static?
+kernel/sys_ni.c:121:1: warning: symbol '__ia32_sys_timerfd_settime' was not declared. Should it be static?
+kernel/sys_ni.c:122:1: warning: symbol '__x64_sys_timerfd_settime32' was not declared. Should it be static?
+kernel/sys_ni.c:122:1: warning: symbol '__ia32_sys_timerfd_settime32' was not declared. Should it be static?
+kernel/sys_ni.c:123:1: warning: symbol '__x64_sys_timerfd_gettime' was not declared. Should it be static?
+kernel/sys_ni.c:123:1: warning: symbol '__ia32_sys_timerfd_gettime' was not declared. Should it be static?
+kernel/sys_ni.c:124:1: warning: symbol '__x64_sys_timerfd_gettime32' was not declared. Should it be static?
+kernel/sys_ni.c:124:1: warning: symbol '__ia32_sys_timerfd_gettime32' was not declared. Should it be static?
+kernel/sys_ni.c:129:1: warning: symbol '__x64_sys_acct' was not declared. Should it be static?
+kernel/sys_ni.c:129:1: warning: symbol '__ia32_sys_acct' was not declared. Should it be static?
+kernel/sys_ni.c:132:1: warning: symbol '__x64_sys_capget' was not declared. Should it be static?
+kernel/sys_ni.c:132:1: warning: symbol '__ia32_sys_capget' was not declared. Should it be static?
+kernel/sys_ni.c:133:1: warning: symbol '__x64_sys_capset' was not declared. Should it be static?
+kernel/sys_ni.c:133:1: warning: symbol '__ia32_sys_capset' was not declared. Should it be static?
+kernel/sys_ni.c:141:1: warning: symbol '__x64_sys_clone3' was not declared. Should it be static?
+kernel/sys_ni.c:141:1: warning: symbol '__ia32_sys_clone3' was not declared. Should it be static?
+kernel/sys_ni.c:144:1: warning: symbol '__x64_sys_futex' was not declared. Should it be static?
+kernel/sys_ni.c:144:1: warning: symbol '__ia32_sys_futex' was not declared. Should it be static?
+kernel/sys_ni.c:145:1: warning: symbol '__x64_sys_futex_time32' was not declared. Should it be static?
+kernel/sys_ni.c:145:1: warning: symbol '__ia32_sys_futex_time32' was not declared. Should it be static?
+kernel/sys_ni.c:146:1: warning: symbol '__x64_sys_set_robust_list' was not declared. Should it be static?
+kernel/sys_ni.c:146:1: warning: symbol '__ia32_sys_set_robust_list' was not declared. Should it be static?
+kernel/sys_ni.c:148:1: warning: symbol '__x64_sys_get_robust_list' was not declared. Should it be static?
+kernel/sys_ni.c:148:1: warning: symbol '__ia32_sys_get_robust_list' was not declared. Should it be static?
+kernel/sys_ni.c:156:1: warning: symbol '__x64_sys_kexec_load' was not declared. Should it be static?
+kernel/sys_ni.c:156:1: warning: symbol '__ia32_sys_kexec_load' was not declared. Should it be static?
+kernel/sys_ni.c:160:1: warning: symbol '__x64_sys_init_module' was not declared. Should it be static?
+kernel/sys_ni.c:160:1: warning: symbol '__ia32_sys_init_module' was not declared. Should it be static?
+kernel/sys_ni.c:161:1: warning: symbol '__x64_sys_delete_module' was not declared. Should it be static?
+kernel/sys_ni.c:161:1: warning: symbol '__ia32_sys_delete_module' was not declared. Should it be static?
+kernel/sys_ni.c:166:1: warning: symbol '__x64_sys_syslog' was not declared. Should it be static?
+kernel/sys_ni.c:166:1: warning: symbol '__ia32_sys_syslog' was not declared. Should it be static?
+kernel/sys_ni.c:173:1: warning: symbol '__x64_sys_setregid' was not declared. Should it be static?
+kernel/sys_ni.c:173:1: warning: symbol '__ia32_sys_setregid' was not declared. Should it be static?
+kernel/sys_ni.c:174:1: warning: symbol '__x64_sys_setgid' was not declared. Should it be static?
+kernel/sys_ni.c:174:1: warning: symbol '__ia32_sys_setgid' was not declared. Should it be static?
+kernel/sys_ni.c:175:1: warning: symbol '__x64_sys_setreuid' was not declared. Should it be static?
+kernel/sys_ni.c:175:1: warning: symbol '__ia32_sys_setreuid' was not declared. Should it be static?
+kernel/sys_ni.c:176:1: warning: symbol '__x64_sys_setuid' was not declared. Should it be static?
+kernel/sys_ni.c:176:1: warning: symbol '__ia32_sys_setuid' was not declared. Should it be static?
+kernel/sys_ni.c:177:1: warning: symbol '__x64_sys_setresuid' was not declared. Should it be static?
+kernel/sys_ni.c:177:1: warning: symbol '__ia32_sys_setresuid' was not declared. Should it be static?
+kernel/sys_ni.c:178:1: warning: symbol '__x64_sys_getresuid' was not declared. Should it be static?
+kernel/sys_ni.c:178:1: warning: symbol '__ia32_sys_getresuid' was not declared. Should it be static?
+kernel/sys_ni.c:179:1: warning: symbol '__x64_sys_setresgid' was not declared. Should it be static?
+kernel/sys_ni.c:179:1: warning: symbol '__ia32_sys_setresgid' was not declared. Should it be static?
+kernel/sys_ni.c:180:1: warning: symbol '__x64_sys_getresgid' was not declared. Should it be static?
+kernel/sys_ni.c:180:1: warning: symbol '__ia32_sys_getresgid' was not declared. Should it be static?
+kernel/sys_ni.c:181:1: warning: symbol '__x64_sys_setfsuid' was not declared. Should it be static?
+kernel/sys_ni.c:181:1: warning: too many warnings
+  CC      kernel/sys_ni.o
+  CHECK   kernel/nsproxy.c
+  CC      kernel/nsproxy.o
+  CHECK   kernel/notifier.c
+kernel/notifier.c:29:20: warning: incorrect type in assignment (different address spaces)
+kernel/notifier.c:29:20:    expected struct notifier_block **nl
+kernel/notifier.c:29:20:    got struct notifier_block [noderef] <asn:4> **
+kernel/notifier.c:31:17: warning: incorrect type in assignment (different address spaces)
+kernel/notifier.c:31:17:    expected struct notifier_block [noderef] <asn:4> *next
+kernel/notifier.c:31:17:    got struct notifier_block *
+kernel/notifier.c:32:9: error: incompatible types in comparison expression (different address spaces):
+kernel/notifier.c:32:9:    struct notifier_block [noderef] <asn:4> *
+kernel/notifier.c:32:9:    struct notifier_block *
+kernel/notifier.c:44:20: warning: incorrect type in assignment (different address spaces)
+kernel/notifier.c:44:20:    expected struct notifier_block **nl
+kernel/notifier.c:44:20:    got struct notifier_block [noderef] <asn:4> **
+kernel/notifier.c:46:17: warning: incorrect type in assignment (different address spaces)
+kernel/notifier.c:46:17:    expected struct notifier_block [noderef] <asn:4> *next
+kernel/notifier.c:46:17:    got struct notifier_block *
+kernel/notifier.c:47:9: error: incompatible types in comparison expression (different address spaces):
+kernel/notifier.c:47:9:    struct notifier_block [noderef] <asn:4> *
+kernel/notifier.c:47:9:    struct notifier_block *
+kernel/notifier.c:56:25: error: incompatible types in comparison expression (different address spaces):
+kernel/notifier.c:56:25:    struct notifier_block [noderef] <asn:4> *
+kernel/notifier.c:56:25:    struct notifier_block *
+kernel/notifier.c:130:40: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:152:42: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:185:36: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:226:49: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:229:40: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:252:45: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:279:51: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:282:42: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:319:44: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:352:41: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:369:43: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:396:37: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:434:49: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:437:40: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:464:51: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:467:42: warning: incorrect type in argument 1 (different address spaces)
+kernel/notifier.c:500:36: warning: incorrect type in argument 1 (different address spaces)
+  CC      kernel/notifier.o
+  CHECK   kernel/ksysfs.c
+kernel/ksysfs.c:150:5: warning: symbol 'rcu_expedited' was not declared. Should it be static?
+kernel/ksysfs.c:167:5: warning: symbol 'rcu_normal' was not declared. Should it be static?
+  CC      kernel/ksysfs.o
+  CHECK   kernel/cred.c
+kernel/cred.c:144:9: error: incompatible types in comparison expression (different address spaces):
+kernel/cred.c:144:9:    struct cred *
+kernel/cred.c:144:9:    struct cred const [noderef] <asn:4> *
+kernel/cred.c:145:9: error: incompatible types in comparison expression (different address spaces):
+kernel/cred.c:145:9:    struct cred *
+kernel/cred.c:145:9:    struct cred const [noderef] <asn:4> *
+kernel/cred.c:161:9: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:161:9:    expected struct atomic_t const [usertype] *v
+kernel/cred.c:161:9:    got struct atomic_t const [noderef] <asn:4> *
+kernel/cred.c:161:9: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:161:9:    expected struct cred const *cred
+kernel/cred.c:161:9:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:165:17: warning: cast removes address space '<asn:4>' of expression
+kernel/cred.c:171:17: warning: cast removes address space '<asn:4>' of expression
+kernel/cred.c:264:13: warning: incorrect type in assignment (different address spaces)
+kernel/cred.c:264:13:    expected struct cred const *old
+kernel/cred.c:264:13:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:345:42: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:345:42:    expected struct cred const *cred
+kernel/cred.c:345:42:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:345:30: warning: incorrect type in assignment (different address spaces)
+kernel/cred.c:345:30:    expected struct cred const [noderef] <asn:4> *real_cred
+kernel/cred.c:345:30:    got struct cred const *
+kernel/cred.c:346:27: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:346:27:    expected struct cred const *cred
+kernel/cred.c:346:27:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:347:41: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:347:41:    expected struct cred const *_cred
+kernel/cred.c:347:41:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:348:17: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:348:17:    expected struct atomic_t const [usertype] *v
+kernel/cred.c:348:17:    got struct atomic_t const [noderef] <asn:4> *
+kernel/cred.c:348:17: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:348:17:    expected struct cred const *cred
+kernel/cred.c:348:17:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:385:32: warning: incorrect type in assignment (different address spaces)
+kernel/cred.c:385:32:    expected struct cred const [noderef] <asn:4> *real_cred
+kernel/cred.c:385:32:    got struct cred const *
+kernel/cred.c:437:38: warning: incorrect type in initializer (different address spaces)
+kernel/cred.c:437:38:    expected struct cred const *old
+kernel/cred.c:437:38:    got struct cred const [noderef] <asn:4> *real_cred
+kernel/cred.c:443:9: error: incompatible types in comparison expression (different address spaces):
+kernel/cred.c:443:9:    struct cred const [noderef] <asn:4> *
+kernel/cred.c:443:9:    struct cred const *
+kernel/cred.c:543:41: warning: incorrect type in initializer (different address spaces)
+kernel/cred.c:543:41:    expected struct cred const *old
+kernel/cred.c:543:41:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:584:46: warning: incorrect type in initializer (different address spaces)
+kernel/cred.c:584:46:    expected struct cred const *override
+kernel/cred.c:584:46:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:807:21: error: incompatible types in comparison expression (different address spaces):
+kernel/cred.c:807:21:    struct cred const *
+kernel/cred.c:807:21:    struct cred const [noderef] <asn:4> *
+kernel/cred.c:854:21: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:854:21:    expected struct cred const *cred
+kernel/cred.c:854:21:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:854:21: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:854:21:    expected struct cred const *cred
+kernel/cred.c:854:21:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:858:21: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:858:21:    expected struct cred const *cred
+kernel/cred.c:858:21:    got struct cred const [noderef] <asn:4> *real_cred
+kernel/cred.c:858:21: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:858:21:    expected struct cred const *cred
+kernel/cred.c:858:21:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:858:21: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:858:21:    expected struct cred const *cred
+kernel/cred.c:858:21:    got struct cred const [noderef] <asn:4> *real_cred
+kernel/cred.c:858:21: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:858:21:    expected struct cred const *cred
+kernel/cred.c:858:21:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:870:31: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:870:31:    expected struct cred const *cred
+kernel/cred.c:870:31:    got struct cred const [noderef] <asn:4> *real_cred
+kernel/cred.c:872:39: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:872:39:    expected struct cred const *cred
+kernel/cred.c:872:39:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:884:9: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:884:9:    expected struct atomic_t const [usertype] *v
+kernel/cred.c:884:9:    got struct atomic_t const [noderef] <asn:4> *
+kernel/cred.c:884:9: warning: incorrect type in argument 1 (different address spaces)
+kernel/cred.c:884:9:    expected struct cred const *cred
+kernel/cred.c:884:9:    got struct cred const [noderef] <asn:4> *cred
+kernel/cred.c:341:19: warning: dereference of noderef expression
+kernel/cred.c:351:30: warning: dereference of noderef expression
+  CC      kernel/cred.o
+  CHECK   kernel/reboot.c
+  CC      kernel/reboot.o
+  CHECK   kernel/async.c
+  CC      kernel/async.o
+  CHECK   kernel/range.c
+  CC      kernel/range.o
+  CHECK   kernel/smpboot.c
+  CC      kernel/smpboot.o
+  CHECK   kernel/ucount.c
+  CC      kernel/ucount.o
+  CHECK   kernel/kmod.c
+  CC      kernel/kmod.o
+  CHECK   kernel/groups.c
+  CC      kernel/groups.o
+  CHECK   kernel/bpf/core.c
+kernel/bpf/core.c:207:49: error: arithmetics on pointers to functions
+./include/linux/rbtree.h:84:9: error: incompatible types in comparison expression (different address spaces):
+./include/linux/rbtree.h:84:9:    struct rb_node [noderef] <asn:4> *
+./include/linux/rbtree.h:84:9:    struct rb_node *
+./include/linux/rbtree.h:84:9: error: incompatible types in comparison expression (different address spaces):
+./include/linux/rbtree.h:84:9:    struct rb_node [noderef] <asn:4> *
+./include/linux/rbtree.h:84:9:    struct rb_node *
+./include/trace/events/xdp.h:318:1: warning: Using plain integer as NULL pointer
+./include/trace/events/xdp.h:345:1: warning: Using plain integer as NULL pointer
+./include/trace/events/xdp.h:379:1: warning: Using plain integer as NULL pointer
+  CC      kernel/bpf/core.o
+  CHECK   kernel/bpf/syscall.c
+  CC      kernel/bpf/syscall.o
+  CHECK   kernel/bpf/verifier.c
+kernel/bpf/verifier.c:237:12: warning: symbol 'btf_vmlinux' was not declared. Should it be static?
+kernel/bpf/verifier.c:9017:76: error: subtraction of functions? Share your drugs
+kernel/bpf/verifier.c:9391:81: error: subtraction of functions? Share your drugs
+kernel/bpf/verifier.c:9395:81: error: subtraction of functions? Share your drugs
+kernel/bpf/verifier.c:9399:81: error: subtraction of functions? Share your drugs
+kernel/bpf/verifier.c:9403:79: error: subtraction of functions? Share your drugs
+kernel/bpf/verifier.c:9407:78: error: subtraction of functions? Share your drugs
+kernel/bpf/verifier.c:9411:79: error: subtraction of functions? Share your drugs
+kernel/bpf/verifier.c:9430:38: error: subtraction of functions? Share your drugs
+  CC      kernel/bpf/verifier.o
+  CHECK   kernel/bpf/inode.c
+  CC      kernel/bpf/inode.o
+  CHECK   kernel/bpf/helpers.c
+  CC      kernel/bpf/helpers.o
+  CHECK   kernel/bpf/tnum.c
+  CC      kernel/bpf/tnum.o
+  CHECK   kernel/bpf/hashtab.c
+kernel/bpf/hashtab.c:510:19: error: subtraction of functions? Share your drugs
+kernel/bpf/hashtab.c:551:19: error: subtraction of functions? Share your drugs
+kernel/bpf/hashtab.c:1488:19: error: subtraction of functions? Share your drugs
+  CC      kernel/bpf/hashtab.o
+  CHECK   kernel/bpf/arraymap.c
+  CC      kernel/bpf/arraymap.o
+  CHECK   kernel/bpf/percpu_freelist.c
+  CC      kernel/bpf/percpu_freelist.o
+  CHECK   kernel/bpf/bpf_lru_list.c
+  CC      kernel/bpf/bpf_lru_list.o
+  CHECK   kernel/bpf/lpm_trie.c
+  CC      kernel/bpf/lpm_trie.o
+  CHECK   kernel/bpf/map_in_map.c
+  CC      kernel/bpf/map_in_map.o
+  CHECK   kernel/bpf/local_storage.c
+kernel/bpf/local_storage.c:73:47: warning: context imbalance in 'cgroup_storage_lookup' - unexpected unlock
+  CC      kernel/bpf/local_storage.o
+  CHECK   kernel/bpf/queue_stack_maps.c
+  CC      kernel/bpf/queue_stack_maps.o
+  CHECK   kernel/bpf/disasm.c
+  CC      kernel/bpf/disasm.o
+  CHECK   kernel/bpf/trampoline.c
+./arch/x86/include/asm/preempt.h:79:9: warning: context imbalance in '__bpf_prog_enter' - wrong count at exit
+./include/linux/rcupdate.h:669:9: warning: context imbalance in '__bpf_prog_exit' - unexpected unlock
+  CC      kernel/bpf/trampoline.o
+  CHECK   kernel/bpf/btf.c
+  CC      kernel/bpf/btf.o
+  CHECK   kernel/bpf/devmap.c
+  CC      kernel/bpf/devmap.o
+  CHECK   kernel/bpf/cpumap.c
+  CC      kernel/bpf/cpumap.o
+  CHECK   kernel/bpf/xskmap.c
+  CC      kernel/bpf/xskmap.o
+  CHECK   kernel/bpf/offload.c
+  CC      kernel/bpf/offload.o
+  CHECK   kernel/bpf/stackmap.c
+  CC      kernel/bpf/stackmap.o
+  CHECK   kernel/bpf/cgroup.c
+  CC      kernel/bpf/cgroup.o
+  CHECK   kernel/bpf/reuseport_array.c
+  CC      kernel/bpf/reuseport_array.o
+  AR      kernel/bpf/built-in.a
+  CHECK   kernel/cgroup/cgroup.c
+kernel/cgroup/cgroup.c:2753:20: warning: context imbalance in 'cgroup_procs_write_start' - wrong count at exit
+kernel/cgroup/cgroup.c:2828:9: warning: context imbalance in 'cgroup_procs_write_finish' - wrong count at exit
+kernel/cgroup/cgroup.c:2939:9: warning: context imbalance in 'cgroup_lock_and_drain_offline' - wrong count at exit
+kernel/cgroup/cgroup.c:4693:16: warning: context imbalance in 'cgroup_procs_write' - wrong count at exit
+kernel/cgroup/cgroup.c:4735:16: warning: context imbalance in 'cgroup_threads_write' - wrong count at exit
+  CC      kernel/cgroup/cgroup.o
+  CHECK   kernel/cgroup/rstat.c
+  CC      kernel/cgroup/rstat.o
+  CHECK   kernel/cgroup/namespace.c
+  CC      kernel/cgroup/namespace.o
+  CHECK   kernel/cgroup/cgroup-v1.c
+kernel/cgroup/cgroup-v1.c:490:16: warning: context imbalance in '__cgroup1_procs_write' - wrong count at exit
+  CC      kernel/cgroup/cgroup-v1.o
+  CHECK   kernel/cgroup/freezer.c
+  CC      kernel/cgroup/freezer.o
+  CHECK   kernel/cgroup/legacy_freezer.c
+  CC      kernel/cgroup/legacy_freezer.o
+  CHECK   kernel/cgroup/pids.c
+  CC      kernel/cgroup/pids.o
+  CHECK   kernel/cgroup/rdma.c
+  CC      kernel/cgroup/rdma.o
+  CHECK   kernel/cgroup/cpuset.c
+  CC      kernel/cgroup/cpuset.o
+  CHECK   kernel/cgroup/debug.c
+kernel/cgroup/debug.c:133:21: error: incompatible types in comparison expression (different address spaces):
+kernel/cgroup/debug.c:133:21:    struct css_set [noderef] <asn:4> *
+kernel/cgroup/debug.c:133:21:    struct css_set *
+  CC      kernel/cgroup/debug.o
+  AR      kernel/cgroup/built-in.a
+  CHECK   kernel/debug/debug_core.c
+kernel/debug/debug_core.c:552:9: warning: context imbalance in 'kgdb_cpu_enter' - different lock contexts for basic block
+  CC      kernel/debug/debug_core.o
+  CHECK   kernel/debug/gdbstub.c
+  CC      kernel/debug/gdbstub.o
+  CHECK   kernel/debug/kdb/kdb_io.c
+  CC      kernel/debug/kdb/kdb_io.o
+  CHECK   kernel/debug/kdb/kdb_main.c
+kernel/debug/kdb/kdb_main.c:2330:40: warning: dereference of noderef expression
+  CC      kernel/debug/kdb/kdb_main.o
+  CHECK   kernel/debug/kdb/kdb_support.c
+  CC      kernel/debug/kdb/kdb_support.o
+  CHECK   kernel/debug/kdb/kdb_bt.c
+  CC      kernel/debug/kdb/kdb_bt.o
+  CHECK   kernel/debug/kdb/gen-kdb_cmds.c
+  CC      kernel/debug/kdb/gen-kdb_cmds.o
+  CHECK   kernel/debug/kdb/kdb_bp.c
+  CC      kernel/debug/kdb/kdb_bp.o
+  CHECK   kernel/debug/kdb/kdb_debugger.c
+  CC      kernel/debug/kdb/kdb_debugger.o
+  CHECK   kernel/debug/kdb/kdb_keyboard.c
+kernel/debug/kdb/kdb_keyboard.c:199:6: warning: symbol 'kdb_kbd_cleanup_state' was not declared. Should it be static?
+  CC      kernel/debug/kdb/kdb_keyboard.o
+  AR      kernel/debug/kdb/built-in.a
+  AR      kernel/debug/built-in.a
+  CHECK   kernel/dma/mapping.c
+  CC      kernel/dma/mapping.o
+  CHECK   kernel/dma/direct.c
+  CC      kernel/dma/direct.o
+  CHECK   kernel/dma/dummy.c
+  CC      kernel/dma/dummy.o
+  CHECK   kernel/dma/contiguous.c
+  CC      kernel/dma/contiguous.o
+  CHECK   kernel/dma/coherent.c
+  CC      kernel/dma/coherent.o
+  CHECK   kernel/dma/virt.c
+  CC      kernel/dma/virt.o
+  CHECK   kernel/dma/debug.c
+kernel/dma/debug.c:657:6: warning: symbol '__dma_entry_alloc_check_leak' was not declared. Should it be static?
+  CC      kernel/dma/debug.o
+  CHECK   kernel/dma/swiotlb.c
+kernel/dma/swiotlb.c:95:14: warning: symbol 'max_segment' was not declared. Should it be static?
+kernel/dma/swiotlb.c:277:1: warning: symbol 'swiotlb_late_init_with_default_size' was not declared. Should it be static?
+  CC      kernel/dma/swiotlb.o
+  AR      kernel/dma/built-in.a
+  CHECK   kernel/events/core.c
+kernel/events/core.c:571:26: warning: function 'perf_pmu_name' with external linkage has definition
+kernel/events/core.c:1384:15: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:1384:15:    struct perf_event_context [noderef] <asn:4> *
+kernel/events/core.c:1384:15:    struct perf_event_context *
+kernel/events/core.c:1397:28: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:1397:28:    struct perf_event_context [noderef] <asn:4> *
+kernel/events/core.c:1397:28:    struct perf_event_context *
+kernel/events/core.c:3221:18: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:3221:18:    struct perf_event_context [noderef] <asn:4> *
+kernel/events/core.c:3221:18:    struct perf_event_context *
+kernel/events/core.c:3222:23: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:3222:23:    struct perf_event_context [noderef] <asn:4> *
+kernel/events/core.c:3222:23:    struct perf_event_context *
+kernel/events/core.c:3264:25: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:3264:25:    struct perf_event_context [noderef] <asn:4> *
+kernel/events/core.c:3264:25:    struct perf_event_context *
+kernel/events/core.c:3265:25: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:3265:25:    struct perf_event_context [noderef] <asn:4> *
+kernel/events/core.c:3265:25:    struct perf_event_context *
+kernel/events/core.c:4340:25: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:4340:25:    struct perf_event_context [noderef] <asn:4> *
+kernel/events/core.c:4340:25:    struct perf_event_context *
+kernel/events/core.c:5596:9: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:5596:9:    struct ring_buffer [noderef] <asn:4> *
+kernel/events/core.c:5596:9:    struct ring_buffer *
+kernel/events/core.c:5072:24: warning: incorrect type in assignment (different base types)
+kernel/events/core.c:5072:24:    expected restricted __poll_t [usertype] events
+kernel/events/core.c:5072:24:    got int
+kernel/events/core.c:5302:22: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:5302:22:    struct ring_buffer [noderef] <asn:4> *
+kernel/events/core.c:5302:22:    struct ring_buffer *
+kernel/events/core.c:5438:14: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:5438:14:    struct ring_buffer [noderef] <asn:4> *
+kernel/events/core.c:5438:14:    struct ring_buffer *
+kernel/events/core.c:5454:13: warning: symbol 'arch_perf_update_userpage' was not declared. Should it be static?
+kernel/events/core.c:5471:14: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:5471:14:    struct ring_buffer [noderef] <asn:4> *
+kernel/events/core.c:5471:14:    struct ring_buffer *
+kernel/events/core.c:5528:14: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:5528:14:    struct ring_buffer [noderef] <asn:4> *
+kernel/events/core.c:5528:14:    struct ring_buffer *
+kernel/events/core.c:5614:14: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:5614:14:    struct ring_buffer [noderef] <asn:4> *
+kernel/events/core.c:5614:14:    struct ring_buffer *
+kernel/events/core.c:5627:14: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:5627:14:    struct ring_buffer [noderef] <asn:4> *
+kernel/events/core.c:5627:14:    struct ring_buffer *
+kernel/events/internal.h:204:1: warning: incorrect type in argument 2 (different address spaces)
+kernel/events/internal.h:204:1:    expected void const [noderef] <asn:1> *from
+kernel/events/internal.h:204:1:    got void const *buf
+kernel/events/core.c:6302:6: warning: symbol 'perf_pmu_snapshot_aux' was not declared. Should it be static?
+kernel/events/core.c:7091:23: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:7091:23:    struct perf_event_context [noderef] <asn:4> *
+kernel/events/core.c:7091:23:    struct perf_event_context *
+kernel/events/core.c:7182:13: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:7182:13:    struct ring_buffer [noderef] <asn:4> *
+kernel/events/core.c:7182:13:    struct ring_buffer *
+kernel/events/core.c:7870:23: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:7870:23:    struct perf_event_context [noderef] <asn:4> *
+kernel/events/core.c:7870:23:    struct perf_event_context *
+kernel/events/core.c:8600:17: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:8600:17:    struct swevent_hlist [noderef] <asn:4> *
+kernel/events/core.c:8600:17:    struct swevent_hlist *
+kernel/events/core.c:8620:17: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:8620:17:    struct swevent_hlist [noderef] <asn:4> *
+kernel/events/core.c:8620:17:    struct swevent_hlist *
+kernel/events/core.c:8740:16: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:8740:16:    struct swevent_hlist [noderef] <asn:4> *
+kernel/events/core.c:8740:16:    struct swevent_hlist *
+kernel/events/core.c:8751:9: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:8751:9:    struct swevent_hlist [noderef] <asn:4> *
+kernel/events/core.c:8751:9:    struct swevent_hlist *
+kernel/events/core.c:8740:16: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:8740:16:    struct swevent_hlist [noderef] <asn:4> *
+kernel/events/core.c:8740:16:    struct swevent_hlist *
+kernel/events/core.c:8790:17: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:8790:17:    struct swevent_hlist [noderef] <asn:4> *
+kernel/events/core.c:8790:17:    struct swevent_hlist *
+kernel/events/core.c:8971:23: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:8971:23:    struct perf_event_context [noderef] <asn:4> *
+kernel/events/core.c:8971:23:    struct perf_event_context *
+kernel/events/core.c:10142:1: warning: symbol 'dev_attr_nr_addr_filters' was not declared. Should it be static?
+kernel/events/core.c:11863:9: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:11863:9:    struct perf_event_context [noderef] <asn:4> *
+kernel/events/core.c:11863:9:    struct perf_event_context *
+kernel/events/core.c:11973:17: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:11973:17:    struct perf_event_context [noderef] <asn:4> *
+kernel/events/core.c:11973:17:    struct perf_event_context *
+kernel/events/core.c:8740:16: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:8740:16:    struct swevent_hlist [noderef] <asn:4> *
+kernel/events/core.c:8740:16:    struct swevent_hlist *
+kernel/events/core.c:12397:17: error: incompatible types in comparison expression (different address spaces):
+kernel/events/core.c:12397:17:    struct swevent_hlist [noderef] <asn:4> *
+kernel/events/core.c:12397:17:    struct swevent_hlist *
+kernel/events/core.c:155:9: warning: context imbalance in 'perf_ctx_lock' - wrong count at exit
+kernel/events/core.c:163:17: warning: context imbalance in 'perf_ctx_unlock' - unexpected unlock
+kernel/events/core.c:1404:17: warning: context imbalance in 'perf_lock_task_context' - different lock contexts for basic block
+kernel/events/core.c:1431:17: warning: context imbalance in 'perf_pin_task_context' - unexpected unlock
+kernel/events/core.c:2651:9: warning: context imbalance in '__perf_install_in_context' - wrong count at exit
+kernel/events/core.c:4312:17: warning: context imbalance in 'find_get_context' - unexpected unlock
+  CC      kernel/events/core.o
+  CHECK   kernel/events/ring_buffer.c
+kernel/events/ring_buffer.c:22:39: warning: incorrect type in argument 2 (different base types)
+kernel/events/ring_buffer.c:22:39:    expected int i
+kernel/events/ring_buffer.c:22:39:    got restricted __poll_t [usertype]
+kernel/events/ring_buffer.c:169:14: error: incompatible types in comparison expression (different address spaces):
+kernel/events/ring_buffer.c:169:14:    struct ring_buffer [noderef] <asn:4> *
+kernel/events/ring_buffer.c:169:14:    struct ring_buffer *
+kernel/events/ring_buffer.c:169:14: error: incompatible types in comparison expression (different address spaces):
+kernel/events/ring_buffer.c:169:14:    struct ring_buffer [noderef] <asn:4> *
+kernel/events/ring_buffer.c:169:14:    struct ring_buffer *
+kernel/events/ring_buffer.c:169:14: error: incompatible types in comparison expression (different address spaces):
+kernel/events/ring_buffer.c:169:14:    struct ring_buffer [noderef] <asn:4> *
+kernel/events/ring_buffer.c:169:14:    struct ring_buffer *
+kernel/events/ring_buffer.c:149:1: warning: context imbalance in 'perf_output_begin_forward' - different lock contexts for basic block
+kernel/events/ring_buffer.c:149:1: warning: context imbalance in 'perf_output_begin_backward' - different lock contexts for basic block
+kernel/events/ring_buffer.c:149:1: warning: context imbalance in 'perf_output_begin' - different lock contexts for basic block
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'perf_output_end' - unexpected unlock
+  CC      kernel/events/ring_buffer.o
+  CHECK   kernel/events/callchain.c
+kernel/events/callchain.c:66:9: error: incompatible types in comparison expression (different address spaces):
+kernel/events/callchain.c:66:9:    struct callchain_cpus_entries [noderef] <asn:4> *
+kernel/events/callchain.c:66:9:    struct callchain_cpus_entries *
+kernel/events/callchain.c:96:9: error: incompatible types in comparison expression (different address spaces):
+kernel/events/callchain.c:96:9:    struct callchain_cpus_entries [noderef] <asn:4> *
+kernel/events/callchain.c:96:9:    struct callchain_cpus_entries *
+kernel/events/callchain.c:161:19: error: incompatible types in comparison expression (different address spaces):
+kernel/events/callchain.c:161:19:    struct callchain_cpus_entries [noderef] <asn:4> *
+kernel/events/callchain.c:161:19:    struct callchain_cpus_entries *
+  CC      kernel/events/callchain.o
+  CHECK   kernel/events/hw_breakpoint.c
+kernel/events/hw_breakpoint.c:71:12: warning: symbol 'hw_breakpoint_weight' was not declared. Should it be static?
+kernel/events/hw_breakpoint.c:219:13: warning: symbol 'arch_unregister_hw_breakpoint' was not declared. Should it be static?
+  CC      kernel/events/hw_breakpoint.o
+  CHECK   kernel/events/uprobes.c
+./include/linux/rmap.h:220:28: warning: context imbalance in '__replace_page' - unexpected unlock
+  CC      kernel/events/uprobes.o
+  AR      kernel/events/built-in.a
+  CHECK   kernel/gcov/base.c
+  CC      kernel/gcov/base.o
+  CHECK   kernel/gcov/fs.c
+  CC      kernel/gcov/fs.o
+  CHECK   kernel/gcov/gcc_base.c
+kernel/gcov/gcc_base.c:12:6: warning: symbol '__gcov_init' was not declared. Should it be static?
+kernel/gcov/gcc_base.c:40:6: warning: symbol '__gcov_flush' was not declared. Should it be static?
+kernel/gcov/gcc_base.c:46:6: warning: symbol '__gcov_merge_add' was not declared. Should it be static?
+kernel/gcov/gcc_base.c:52:6: warning: symbol '__gcov_merge_single' was not declared. Should it be static?
+kernel/gcov/gcc_base.c:58:6: warning: symbol '__gcov_merge_delta' was not declared. Should it be static?
+kernel/gcov/gcc_base.c:64:6: warning: symbol '__gcov_merge_ior' was not declared. Should it be static?
+kernel/gcov/gcc_base.c:70:6: warning: symbol '__gcov_merge_time_profile' was not declared. Should it be static?
+kernel/gcov/gcc_base.c:76:6: warning: symbol '__gcov_merge_icall_topn' was not declared. Should it be static?
+kernel/gcov/gcc_base.c:82:6: warning: symbol '__gcov_exit' was not declared. Should it be static?
+  CC      kernel/gcov/gcc_base.o
+  CHECK   kernel/gcov/gcc_4_7.c
+  CC      kernel/gcov/gcc_4_7.o
+  AR      kernel/gcov/built-in.a
+  CHECK   kernel/irq/irqdesc.c
+kernel/irq/irqdesc.c:869:17: warning: context imbalance in '__irq_get_desc_lock' - wrong count at exit
+kernel/irq/irqdesc.c:893:6: warning: context imbalance in '__irq_put_desc_unlock' - unexpected unlock
+  CC      kernel/irq/irqdesc.o
+  CHECK   kernel/irq/handle.c
+  CC      kernel/irq/handle.o
+  CHECK   kernel/irq/manage.c
+  CC      kernel/irq/manage.o
+  CHECK   kernel/irq/spurious.c
+kernel/irq/spurious.c:45:17: warning: context imbalance in 'irq_wait_for_poll' - unexpected unlock
+  CC      kernel/irq/spurious.o
+  CHECK   kernel/irq/resend.c
+  CC      kernel/irq/resend.o
+  CHECK   kernel/irq/chip.c
+  CC      kernel/irq/chip.o
+  CHECK   kernel/irq/dummychip.c
+  CC      kernel/irq/dummychip.o
+  CHECK   kernel/irq/devres.c
+  CC      kernel/irq/devres.o
+  CHECK   kernel/irq/generic-chip.c
+  CC      kernel/irq/generic-chip.o
+  CHECK   kernel/irq/autoprobe.c
+  CC      kernel/irq/autoprobe.o
+  CHECK   kernel/irq/irqdomain.c
+kernel/irq/irqdomain.c:1786:13: warning: symbol 'irq_domain_debugfs_init' was not declared. Should it be static?
+  CC      kernel/irq/irqdomain.o
+  CHECK   kernel/irq/irq_sim.c
+  CC      kernel/irq/irq_sim.o
+  CHECK   kernel/irq/proc.c
+  CC      kernel/irq/proc.o
+  CHECK   kernel/irq/migration.c
+  CC      kernel/irq/migration.o
+  CHECK   kernel/irq/cpuhotplug.c
+  CC      kernel/irq/cpuhotplug.o
+  CHECK   kernel/irq/pm.c
+  CC      kernel/irq/pm.o
+  CHECK   kernel/irq/msi.c
+  CC      kernel/irq/msi.o
+  CHECK   kernel/irq/affinity.c
+  CC      kernel/irq/affinity.o
+  CHECK   kernel/irq/debugfs.c
+  CC      kernel/irq/debugfs.o
+  CHECK   kernel/irq/matrix.c
+  CC      kernel/irq/matrix.o
+  AR      kernel/irq/built-in.a
+  CHECK   kernel/livepatch/core.c
+  CC      kernel/livepatch/core.o
+  CHECK   kernel/livepatch/patch.c
+  CC      kernel/livepatch/patch.o
+  CHECK   kernel/livepatch/shadow.c
+  CC      kernel/livepatch/shadow.o
+  CHECK   kernel/livepatch/state.c
+  CC      kernel/livepatch/state.o
+  CHECK   kernel/livepatch/transition.c
+  CC      kernel/livepatch/transition.o
+  AR      kernel/livepatch/built-in.a
+  CHECK   kernel/locking/mutex.c
+  CC      kernel/locking/mutex.o
+  CHECK   kernel/locking/semaphore.c
+  CC      kernel/locking/semaphore.o
+  CHECK   kernel/locking/rwsem.c
+  CC      kernel/locking/rwsem.o
+  CHECK   kernel/locking/percpu-rwsem.c
+  CC      kernel/locking/percpu-rwsem.o
+  CHECK   kernel/locking/mutex-debug.c
+  CC      kernel/locking/mutex-debug.o
+  CHECK   kernel/locking/lockdep.c
+kernel/locking/lockdep.c:1053:5: warning: symbol 'check_consistency' was not declared. Should it be static?
+  CC      kernel/locking/lockdep.o
+  CHECK   kernel/locking/lockdep_proc.c
+kernel/locking/lockdep_proc.c:425:17: error: incompatible types in comparison expression (different address spaces):
+kernel/locking/lockdep_proc.c:425:17:    char const [noderef] <asn:4> *
+kernel/locking/lockdep_proc.c:425:17:    char const *
+kernel/locking/lockdep_proc.c:426:17: error: incompatible types in comparison expression (different address spaces):
+kernel/locking/lockdep_proc.c:426:17:    struct lockdep_subclass_key const [noderef] <asn:4> *
+kernel/locking/lockdep_proc.c:426:17:    struct lockdep_subclass_key const *
+  CC      kernel/locking/lockdep_proc.o
+  CHECK   kernel/locking/spinlock.c
+./include/linux/spinlock_api_smp.h:143:9: warning: context imbalance in '_raw_spin_lock' - different lock contexts for basic block
+./include/linux/spinlock_api_smp.h:117:9: warning: context imbalance in '_raw_spin_lock_irqsave' - different lock contexts for basic block
+./include/linux/spinlock_api_smp.h:129:9: warning: context imbalance in '_raw_spin_lock_irq' - different lock contexts for basic block
+./include/linux/spinlock_api_smp.h:136:9: warning: context imbalance in '_raw_spin_lock_bh' - different lock contexts for basic block
+kernel/locking/spinlock.c:181:17: warning: context imbalance in '_raw_spin_unlock' - unexpected unlock
+kernel/locking/spinlock.c:189:17: warning: context imbalance in '_raw_spin_unlock_irqrestore' - unexpected unlock
+kernel/locking/spinlock.c:197:17: warning: context imbalance in '_raw_spin_unlock_irq' - unexpected unlock
+kernel/locking/spinlock.c:205:17: warning: context imbalance in '_raw_spin_unlock_bh' - unexpected unlock
+./include/linux/rwlock_api_smp.h:150:9: warning: context imbalance in '_raw_read_lock' - different lock contexts for basic block
+./include/linux/rwlock_api_smp.h:160:9: warning: context imbalance in '_raw_read_lock_irqsave' - different lock contexts for basic block
+./include/linux/rwlock_api_smp.h:170:9: warning: context imbalance in '_raw_read_lock_irq' - different lock contexts for basic block
+./include/linux/rwlock_api_smp.h:177:9: warning: context imbalance in '_raw_read_lock_bh' - different lock contexts for basic block
+kernel/locking/spinlock.c:253:17: warning: context imbalance in '_raw_read_unlock' - unexpected unlock
+kernel/locking/spinlock.c:261:17: warning: context imbalance in '_raw_read_unlock_irqrestore' - unexpected unlock
+kernel/locking/spinlock.c:269:17: warning: context imbalance in '_raw_read_unlock_irq' - unexpected unlock
+kernel/locking/spinlock.c:277:17: warning: context imbalance in '_raw_read_unlock_bh' - unexpected unlock
+./include/linux/rwlock_api_smp.h:211:9: warning: context imbalance in '_raw_write_lock' - different lock contexts for basic block
+./include/linux/rwlock_api_smp.h:187:9: warning: context imbalance in '_raw_write_lock_irqsave' - different lock contexts for basic block
+./include/linux/rwlock_api_smp.h:197:9: warning: context imbalance in '_raw_write_lock_irq' - different lock contexts for basic block
+./include/linux/rwlock_api_smp.h:204:9: warning: context imbalance in '_raw_write_lock_bh' - different lock contexts for basic block
+kernel/locking/spinlock.c:325:17: warning: context imbalance in '_raw_write_unlock' - unexpected unlock
+kernel/locking/spinlock.c:333:17: warning: context imbalance in '_raw_write_unlock_irqrestore' - unexpected unlock
+kernel/locking/spinlock.c:341:17: warning: context imbalance in '_raw_write_unlock_irq' - unexpected unlock
+kernel/locking/spinlock.c:349:17: warning: context imbalance in '_raw_write_unlock_bh' - unexpected unlock
+kernel/locking/spinlock.c:362:9: warning: context imbalance in '_raw_spin_lock_nested' - different lock contexts for basic block
+kernel/locking/spinlock.c:374:9: warning: context imbalance in '_raw_spin_lock_irqsave_nested' - different lock contexts for basic block
+kernel/locking/spinlock.c:385:9: warning: context imbalance in '_raw_spin_lock_nest_lock' - different lock contexts for basic block
+  CC      kernel/locking/spinlock.o
+  CHECK   kernel/locking/osq_lock.c
+  CC      kernel/locking/osq_lock.o
+  CHECK   kernel/locking/qspinlock.c
+kernel/locking/qspinlock_stat.h:36:9: warning: symbol 'lockevent_read' was not declared. Should it be static?
+kernel/locking/qspinlock.c:419:14: warning: incorrect type in assignment (different modifiers)
+kernel/locking/qspinlock.c:419:14:    expected struct mcs_spinlock *[assigned] node
+kernel/locking/qspinlock.c:419:14:    got struct mcs_spinlock [pure] *
+kernel/locking/qspinlock.c:467:22: warning: incorrect type in assignment (different modifiers)
+kernel/locking/qspinlock.c:467:22:    expected struct mcs_spinlock *prev
+kernel/locking/qspinlock.c:467:22:    got struct mcs_spinlock [pure] *
+kernel/locking/qspinlock.c:419:14: warning: incorrect type in assignment (different modifiers)
+kernel/locking/qspinlock.c:419:14:    expected struct mcs_spinlock *[assigned] node
+kernel/locking/qspinlock.c:419:14:    got struct mcs_spinlock [pure] *
+kernel/locking/qspinlock.c:467:22: warning: incorrect type in assignment (different modifiers)
+kernel/locking/qspinlock.c:467:22:    expected struct mcs_spinlock *prev
+kernel/locking/qspinlock.c:467:22:    got struct mcs_spinlock [pure] *
+  CC      kernel/locking/qspinlock.o
+  CHECK   kernel/locking/rtmutex.c
+  CC      kernel/locking/rtmutex.o
+  CHECK   kernel/locking/rtmutex-debug.c
+  CC      kernel/locking/rtmutex-debug.o
+  CHECK   kernel/locking/spinlock_debug.c
+  CC      kernel/locking/spinlock_debug.o
+  CHECK   kernel/locking/qrwlock.c
+  CC      kernel/locking/qrwlock.o
+  CHECK   kernel/locking/lock_events.c
+kernel/locking/lock_events.c:61:16: warning: symbol 'lockevent_read' was not declared. Should it be static?
+  CC      kernel/locking/lock_events.o
+  AR      kernel/locking/built-in.a
+  CHECK   kernel/locking/locktorture.c
+kernel/locking/locktorture.c:575:6: warning: symbol 'torture_percpu_rwsem_init' was not declared. Should it be static?
+kernel/locking/locktorture.c:320:12: warning: context imbalance in 'torture_mutex_lock' - wrong count at exit
+kernel/locking/locktorture.c:340:13: warning: context imbalance in 'torture_mutex_unlock' - wrong count at exit
+kernel/locking/locktorture.c:362:12: warning: context imbalance in 'torture_ww_mutex_lock' - wrong count at exit
+kernel/locking/locktorture.c:407:13: warning: context imbalance in 'torture_ww_mutex_unlock' - wrong count at exit
+kernel/locking/locktorture.c:431:12: warning: context imbalance in 'torture_rtmutex_lock' - wrong count at exit
+kernel/locking/locktorture.c:493:13: warning: context imbalance in 'torture_rtmutex_unlock' - wrong count at exit
+kernel/locking/locktorture.c:511:12: warning: context imbalance in 'torture_rwsem_down_write' - wrong count at exit
+kernel/locking/locktorture.c:531:13: warning: context imbalance in 'torture_rwsem_up_write' - wrong count at exit
+kernel/locking/locktorture.c:536:12: warning: context imbalance in 'torture_rwsem_down_read' - wrong count at exit
+kernel/locking/locktorture.c:556:13: warning: context imbalance in 'torture_rwsem_up_read' - wrong count at exit
+kernel/locking/locktorture.c:580:12: warning: context imbalance in 'torture_percpu_rwsem_down_write' - wrong count at exit
+kernel/locking/locktorture.c:586:13: warning: context imbalance in 'torture_percpu_rwsem_up_write' - wrong count at exit
+./include/linux/percpu-rwsem.h:58:9: warning: context imbalance in 'torture_percpu_rwsem_down_read' - wrong count at exit
+./include/linux/percpu-rwsem.h:94:9: warning: context imbalance in 'torture_percpu_rwsem_up_read' - wrong count at exit
+  CC [M]  kernel/locking/locktorture.o
+  CHECK   kernel/locking/test-ww_mutex.c
+kernel/locking/test-ww_mutex.c:17:25: warning: symbol 'wq' was not declared. Should it be static?
+  CC [M]  kernel/locking/test-ww_mutex.o
+  CHECK   kernel/power/qos.c
+  CC      kernel/power/qos.o
+  CHECK   kernel/power/main.c
+kernel/power/main.c:98:5: warning: symbol 'pm_async_enabled' was not declared. Should it be static?
+kernel/power/main.c:130:34: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:130:38: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:131:38: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:132:62: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:130:55: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:156:38: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:156:46: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:157:54: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:156:67: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:176:31: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:176:36: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:182:13: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:182:21: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:182:39: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:182:47: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:559:34: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:559:38: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:560:31: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:561:57: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:559:55: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:588:38: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:588:46: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:589:47: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:588:67: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:609:31: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:609:36: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:615:13: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:615:21: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:683:31: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:683:36: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:714:13: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:714:21: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:715:55: warning: restricted suspend_state_t degrades to integer
+kernel/power/main.c:716:51: warning: restricted suspend_state_t degrades to integer
+  CC      kernel/power/main.o
+  CHECK   kernel/power/console.c
+  CC      kernel/power/console.o
+  CHECK   kernel/power/process.c
+  CC      kernel/power/process.o
+  CHECK   kernel/power/suspend.c
+kernel/power/suspend.c:90:54: warning: incorrect type in argument 2 (different base types)
+kernel/power/suspend.c:90:54:    expected int val
+kernel/power/suspend.c:90:54:    got restricted suspend_state_t [usertype]
+kernel/power/suspend.c:117:54: warning: incorrect type in argument 2 (different base types)
+kernel/power/suspend.c:117:54:    expected int val
+kernel/power/suspend.c:117:54:    got restricted suspend_state_t [usertype]
+kernel/power/suspend.c:174:19: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:174:47: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:175:19: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:175:51: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:180:26: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:180:65: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:187:42: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:187:51: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:188:38: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:189:51: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:187:72: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:209:34: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:209:73: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:210:27: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:210:59: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:215:34: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:215:69: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:216:21: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:216:42: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:438:33: warning: incorrect type in argument 2 (different base types)
+kernel/power/suspend.c:438:33:    expected int val
+kernel/power/suspend.c:438:33:    got restricted suspend_state_t [usertype] state
+kernel/power/suspend.c:441:33: warning: incorrect type in argument 2 (different base types)
+kernel/power/suspend.c:441:33:    expected int val
+kernel/power/suspend.c:441:33:    got restricted suspend_state_t [usertype] state
+kernel/power/suspend.c:511:53: warning: incorrect type in argument 2 (different base types)
+kernel/power/suspend.c:511:53:    expected int val
+kernel/power/suspend.c:511:53:    got restricted suspend_state_t [usertype] state
+kernel/power/suspend.c:513:53: warning: incorrect type in argument 2 (different base types)
+kernel/power/suspend.c:513:53:    expected int val
+kernel/power/suspend.c:513:53:    got restricted suspend_state_t [usertype] state
+kernel/power/suspend.c:550:52: warning: incorrect type in argument 2 (different base types)
+kernel/power/suspend.c:550:52:    expected int val
+kernel/power/suspend.c:550:52:    got restricted suspend_state_t [usertype] state
+kernel/power/suspend.c:573:9: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:582:52: warning: incorrect type in argument 2 (different base types)
+kernel/power/suspend.c:582:52:    expected int val
+kernel/power/suspend.c:582:52:    got restricted suspend_state_t [usertype] state
+kernel/power/suspend.c:583:9: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:608:13: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:608:22: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:608:39: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:608:48: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend.c:611:9: warning: restricted suspend_state_t degrades to integer
+  CC      kernel/power/suspend.o
+  CHECK   kernel/power/suspend_test.c
+kernel/power/suspend_test.c:97:45: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend_test.c:103:45: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend_test.c:109:45: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend_test.c:168:38: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend_test.c:168:16: warning: incorrect type in assignment (different base types)
+kernel/power/suspend_test.c:168:16:    expected int i
+kernel/power/suspend_test.c:168:16:    got restricted suspend_state_t [usertype]
+kernel/power/suspend_test.c:192:43: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend_test.c:192:56: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend_test.c:193:53: warning: restricted suspend_state_t degrades to integer
+kernel/power/suspend_test.c:192:82: warning: restricted suspend_state_t degrades to integer
+  CC      kernel/power/suspend_test.o
+  CHECK   kernel/power/hibernate.c
+kernel/power/hibernate.c:260:12: warning: symbol 'arch_resume_nosmt' was not declared. Should it be static?
+  CC      kernel/power/hibernate.o
+  CHECK   kernel/power/snapshot.c
+  CC      kernel/power/snapshot.o
+  CHECK   kernel/power/swap.c
+kernel/power/swap.c:298:35: warning: incorrect type in return expression (different base types)
+kernel/power/swap.c:298:35:    expected restricted blk_status_t
+kernel/power/swap.c:298:35:    got int
+kernel/power/swap.c:382:29: warning: incorrect type in assignment (different base types)
+kernel/power/swap.c:382:29:    expected int ret
+kernel/power/swap.c:382:29:    got restricted blk_status_t
+kernel/power/swap.c:466:31: warning: incorrect type in assignment (different base types)
+kernel/power/swap.c:466:31:    expected int [assigned] error
+kernel/power/swap.c:466:31:    got restricted blk_status_t
+kernel/power/swap.c:563:14: warning: incorrect type in assignment (different base types)
+kernel/power/swap.c:563:14:    expected int err2
+kernel/power/swap.c:563:14:    got restricted blk_status_t
+kernel/power/swap.c:849:14: warning: incorrect type in assignment (different base types)
+kernel/power/swap.c:849:14:    expected int err2
+kernel/power/swap.c:849:14:    got restricted blk_status_t
+kernel/power/swap.c:1078:29: warning: incorrect type in assignment (different base types)
+kernel/power/swap.c:1078:29:    expected int [assigned] ret
+kernel/power/swap.c:1078:29:    got restricted blk_status_t
+kernel/power/swap.c:1086:14: warning: incorrect type in assignment (different base types)
+kernel/power/swap.c:1086:14:    expected int err2
+kernel/power/swap.c:1086:14:    got restricted blk_status_t
+kernel/power/swap.c:1320:29: warning: incorrect type in assignment (different base types)
+kernel/power/swap.c:1320:29:    expected int [assigned] ret
+kernel/power/swap.c:1320:29:    got restricted blk_status_t
+kernel/power/swap.c:1374:29: warning: incorrect type in assignment (different base types)
+kernel/power/swap.c:1374:29:    expected int [assigned] ret
+kernel/power/swap.c:1374:29:    got restricted blk_status_t
+  CC      kernel/power/swap.o
+  CHECK   kernel/power/user.c
+  CC      kernel/power/user.o
+  CHECK   kernel/power/autosleep.c
+kernel/power/autosleep.c:46:13: warning: restricted suspend_state_t degrades to integer
+kernel/power/autosleep.c:46:32: warning: restricted suspend_state_t degrades to integer
+kernel/power/autosleep.c:71:13: warning: restricted suspend_state_t degrades to integer
+kernel/power/autosleep.c:71:31: warning: restricted suspend_state_t degrades to integer
+kernel/power/autosleep.c:106:13: warning: restricted suspend_state_t degrades to integer
+kernel/power/autosleep.c:106:21: warning: restricted suspend_state_t degrades to integer
+  CC      kernel/power/autosleep.o
+  CHECK   kernel/power/wakelock.c
+  CC      kernel/power/wakelock.o
+  CHECK   kernel/power/poweroff.c
+  CC      kernel/power/poweroff.o
+  CHECK   kernel/power/energy_model.c
+  CC      kernel/power/energy_model.o
+  AR      kernel/power/built-in.a
+  CHECK   kernel/printk/printk.c
+kernel/printk/printk.c:421:1: warning: symbol 'log_wait' was not declared. Should it be static?
+  CC      kernel/printk/printk.o
+  CHECK   kernel/printk/printk_safe.c
+  CC      kernel/printk/printk_safe.o
+  CHECK   kernel/printk/braille.c
+  CC      kernel/printk/braille.o
+  AR      kernel/printk/built-in.a
+  CHECK   kernel/rcu/update.c
+kernel/rcu/update.c:794:13: warning: incorrect type in argument 1 (different modifiers)
+kernel/rcu/update.c:794:13:    expected int ( *threadfn )( ... )
+kernel/rcu/update.c:794:13:    got int ( [noreturn] * )( ... )
+kernel/rcu/update.c:804:6: warning: context imbalance in 'exit_tasks_rcu_start' - wrong count at exit
+kernel/rcu/update.c:812:6: warning: context imbalance in 'exit_tasks_rcu_finish' - unexpected unlock
+  CC      kernel/rcu/update.o
+  CHECK   kernel/rcu/sync.c
+  CC      kernel/rcu/sync.o
+  CHECK   kernel/rcu/srcutree.c
+  CC      kernel/rcu/srcutree.o
+  CHECK   kernel/rcu/tree.c
+kernel/rcu/tree.c:87:18: warning: symbol 'rcu_state' was not declared. Should it be static?
+kernel/rcu/tree.c:191:15: warning: symbol 'rcu_rnp_online_cpus' was not declared. Should it be static?
+kernel/rcu/tree.c:297:6: warning: symbol 'rcu_dynticks_curr_cpu_in_eqs' was not declared. Should it be static?
+kernel/rcu/tree.c:3336:13: warning: incorrect type in argument 1 (different modifiers)
+kernel/rcu/tree.c:3336:13:    expected int ( *threadfn )( ... )
+kernel/rcu/tree.c:3336:13:    got int ( [noreturn] * )( ... )
+kernel/rcu/tree_plugin.h:1504:5: warning: symbol 'nocb_nobypass_lim_per_jiffy' was not declared. Should it be static?
+kernel/rcu/tree.c:1152:13: warning: context imbalance in 'rcu_start_this_gp' - different lock contexts for basic block
+kernel/rcu/tree.c:1565:9: warning: context imbalance in 'rcu_gp_init' - different lock contexts for basic block
+kernel/rcu/tree.c:2292:9: warning: context imbalance in 'force_qs_rnp' - different lock contexts for basic block
+kernel/rcu/tree.c:2348:25: warning: context imbalance in 'rcu_force_quiescent_state' - unexpected unlock
+kernel/rcu/tree_stall.h:645:17: warning: context imbalance in 'rcu_check_gp_start_stall' - different lock contexts for basic block
+kernel/rcu/tree_exp.h:193:9: warning: context imbalance in '__rcu_report_exp_rnp' - different lock contexts for basic block
+kernel/rcu/tree_plugin.h:1512:13: warning: context imbalance in 'rcu_nocb_bypass_lock' - wrong count at exit
+kernel/rcu/tree_plugin.h:1549:16: warning: context imbalance in 'rcu_nocb_bypass_trylock' - wrong count at exit
+kernel/rcu/tree_plugin.h:1558:9: warning: context imbalance in 'rcu_nocb_bypass_unlock' - unexpected unlock
+kernel/rcu/tree_plugin.h:1565:13: warning: context imbalance in 'rcu_nocb_lock' - wrong count at exit
+kernel/rcu/tree_plugin.h:1581:17: warning: context imbalance in 'rcu_nocb_unlock' - unexpected unlock
+kernel/rcu/tree_plugin.h:1594:17: warning: context imbalance in 'rcu_nocb_unlock_irqrestore' - unexpected unlock
+kernel/rcu/tree_plugin.h:1641:13: warning: context imbalance in 'wake_nocb_gp' - wrong count at exit
+kernel/rcu/tree_plugin.h:1699:17: warning: context imbalance in 'rcu_nocb_do_flush_bypass' - unexpected unlock
+kernel/rcu/tree_plugin.h:1871:13: warning: context imbalance in '__call_rcu_nocb_wake' - wrong count at exit
+kernel/rcu/tree_plugin.h:1933:9: warning: context imbalance in 'do_nocb_bypass_wakeup_timer' - different lock contexts for basic block
+kernel/rcu/tree_plugin.h:1963:9: warning: context imbalance in 'nocb_gp_wait' - different lock contexts for basic block
+kernel/rcu/tree_plugin.h:2090:13: warning: context imbalance in 'nocb_cb_wait' - wrong count at exit
+kernel/rcu/tree_plugin.h:2157:13: warning: context imbalance in 'do_nocb_deferred_wakeup_common' - different lock contexts for basic block
+  CC      kernel/rcu/tree.o
+  CHECK   kernel/rcu/rcu_segcblist.c
+  CC      kernel/rcu/rcu_segcblist.o
+  AR      kernel/rcu/built-in.a
+  CHECK   kernel/rcu/rcutorture.c
+kernel/rcu/rcutorture.c:511:1: warning: symbol '__srcu_struct_srcu_ctl' was not declared. Should it be static?
+kernel/rcu/rcutorture.c:701:12: warning: context imbalance in 'rcu_torture_read_lock_trivial' - wrong count at exit
+kernel/rcu/rcutorture.c:707:13: warning: context imbalance in 'rcu_torture_read_unlock_trivial' - wrong count at exit
+kernel/rcu/rcutorture.c:1181:9: warning: context imbalance in 'rcutorture_one_extend' - different lock contexts for basic block
+  CC [M]  kernel/rcu/rcutorture.o
+  CHECK   kernel/rcu/rcuperf.c
+kernel/rcu/rcuperf.c:180:1: warning: symbol '__srcu_struct_srcu_ctl_perf' was not declared. Should it be static?
+  CC [M]  kernel/rcu/rcuperf.o
+  CHECK   kernel/sched/core.c
+kernel/sched/core.c:562:9: warning: incorrect type in assignment (different address spaces)
+kernel/sched/core.c:562:9:    expected struct sched_domain *[assigned] sd
+kernel/sched/core.c:562:9:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/core.c:2135:6: warning: symbol 'sched_set_stop_task' was not declared. Should it be static?
+kernel/sched/core.c:2194:17: warning: incorrect type in assignment (different address spaces)
+kernel/sched/core.c:2194:17:    expected struct sched_domain *[assigned] sd
+kernel/sched/core.c:2194:17:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/core.c:2372:27: error: incompatible types in comparison expression (different address spaces):
+kernel/sched/core.c:2372:27:    struct task_struct [noderef] <asn:4> *
+kernel/sched/core.c:2372:27:    struct task_struct *
+kernel/sched/core.c:4061:17: error: incompatible types in comparison expression (different address spaces):
+kernel/sched/core.c:4061:17:    struct task_struct [noderef] <asn:4> *
+kernel/sched/core.c:4061:17:    struct task_struct *
+kernel/sched/core.c:6067:9: error: incompatible types in comparison expression (different address spaces):
+kernel/sched/core.c:6067:9:    struct task_struct [noderef] <asn:4> *
+kernel/sched/core.c:6067:9:    struct task_struct *
+kernel/sched/core.c:7372:11: warning: symbol 'max_cfs_quota_period' was not declared. Should it be static?
+  CC      kernel/sched/core.o
+  CHECK   kernel/sched/loadavg.c
+  CC      kernel/sched/loadavg.o
+  CHECK   kernel/sched/clock.c
+  CC      kernel/sched/clock.o
+  CHECK   kernel/sched/cputime.c
+kernel/sched/cputime.c:316:17: warning: context imbalance in 'thread_group_cputime' - different lock contexts for basic block
+  CC      kernel/sched/cputime.o
+  CHECK   kernel/sched/idle.c
+  CC      kernel/sched/idle.o
+  CHECK   kernel/sched/fair.c
+kernel/sched/fair.c:1609:15: error: incompatible types in comparison expression (different address spaces):
+kernel/sched/fair.c:1609:15:    struct task_struct [noderef] <asn:4> *
+kernel/sched/fair.c:1609:15:    struct task_struct *
+kernel/sched/fair.c:5366:1: warning: symbol '__pcpu_scope_load_balance_mask' was not declared. Should it be static?
+kernel/sched/fair.c:5367:1: warning: symbol '__pcpu_scope_select_idle_mask' was not declared. Should it be static?
+kernel/sched/fair.c:6250:20: warning: incorrect type in assignment (different address spaces)
+kernel/sched/fair.c:6250:20:    expected struct sched_domain *[assigned] sd
+kernel/sched/fair.c:6250:20:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/fair.c:6362:9: warning: incorrect type in assignment (different address spaces)
+kernel/sched/fair.c:6362:9:    expected struct sched_domain *[assigned] tmp
+kernel/sched/fair.c:6362:9:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/fair.c:5664:28: warning: incorrect type in assignment (different address spaces)
+kernel/sched/fair.c:5664:28:    expected struct sched_domain *sd
+kernel/sched/fair.c:5664:28:    got struct sched_domain [noderef] <asn:4> *child
+kernel/sched/fair.c:5670:28: warning: incorrect type in assignment (different address spaces)
+kernel/sched/fair.c:5670:28:    expected struct sched_domain *sd
+kernel/sched/fair.c:5670:28:    got struct sched_domain [noderef] <asn:4> *child
+kernel/sched/fair.c:5677:28: warning: incorrect type in assignment (different address spaces)
+kernel/sched/fair.c:5677:28:    expected struct sched_domain *sd
+kernel/sched/fair.c:5677:28:    got struct sched_domain [noderef] <asn:4> *child
+kernel/sched/fair.c:5685:17: warning: incorrect type in assignment (different address spaces)
+kernel/sched/fair.c:5685:17:    expected struct sched_domain *[assigned] tmp
+kernel/sched/fair.c:5685:17:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/fair.c:7751:40: warning: incorrect type in initializer (different address spaces)
+kernel/sched/fair.c:7751:40:    expected struct sched_domain *child
+kernel/sched/fair.c:7751:40:    got struct sched_domain [noderef] <asn:4> *child
+kernel/sched/fair.c:8519:45: warning: incorrect type in initializer (different address spaces)
+kernel/sched/fair.c:8519:45:    expected struct sched_domain *child
+kernel/sched/fair.c:8519:45:    got struct sched_domain [noderef] <asn:4> *child
+kernel/sched/fair.c:9452:9: warning: incorrect type in assignment (different address spaces)
+kernel/sched/fair.c:9452:9:    expected struct sched_domain *[assigned] sd
+kernel/sched/fair.c:9452:9:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/fair.c:9112:44: warning: incorrect type in initializer (different address spaces)
+kernel/sched/fair.c:9112:44:    expected struct sched_domain *sd_parent
+kernel/sched/fair.c:9112:44:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/fair.c:9530:9: warning: incorrect type in assignment (different address spaces)
+kernel/sched/fair.c:9530:9:    expected struct sched_domain *[assigned] sd
+kernel/sched/fair.c:9530:9:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/fair.c:10129:9: warning: incorrect type in assignment (different address spaces)
+kernel/sched/fair.c:10129:9:    expected struct sched_domain *[assigned] sd
+kernel/sched/fair.c:10129:9:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/fair.c:2228:9: warning: context imbalance in 'task_numa_placement' - different lock contexts for basic block
+kernel/sched/fair.c:7793:41: warning: dereference of noderef expression
+kernel/sched/fair.c:9579:1: warning: context imbalance in 'rebalance_domains' - different lock contexts for basic block
+kernel/sched/fair.c:10050:9: warning: context imbalance in 'nohz_newidle_balance' - unexpected unlock
+  CC      kernel/sched/fair.o
+  CHECK   kernel/sched/rt.c
+kernel/sched/rt.c:627:6: warning: symbol 'sched_rt_bandwidth_account' was not declared. Should it be static?
+kernel/sched/rt.c:1668:9: warning: incorrect type in assignment (different address spaces)
+kernel/sched/rt.c:1668:9:    expected struct sched_domain *[assigned] sd
+kernel/sched/rt.c:1668:9:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/sched.h:2041:17: warning: context imbalance in 'find_lock_lowest_rq' - unexpected unlock
+kernel/sched/rt.c:1854:9: warning: context imbalance in 'push_rt_task' - unexpected unlock
+  CC      kernel/sched/rt.o
+  CHECK   kernel/sched/deadline.c
+kernel/sched/deadline.c:1916:9: warning: incorrect type in assignment (different address spaces)
+kernel/sched/deadline.c:1916:9:    expected struct sched_domain *[assigned] sd
+kernel/sched/deadline.c:1916:9:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/deadline.c:590:17: warning: context imbalance in 'dl_task_offline_migration' - unexpected unlock
+kernel/sched/sched.h:2041:17: warning: context imbalance in 'find_lock_later_rq' - unexpected unlock
+kernel/sched/deadline.c:2103:9: warning: context imbalance in 'push_dl_task' - unexpected unlock
+kernel/sched/sched.h:2041:17: warning: context imbalance in 'pull_dl_task' - unexpected unlock
+  CC      kernel/sched/deadline.o
+  CHECK   kernel/sched/wait.c
+  CC      kernel/sched/wait.o
+  CHECK   kernel/sched/wait_bit.c
+  CC      kernel/sched/wait_bit.o
+  CHECK   kernel/sched/swait.c
+  CC      kernel/sched/swait.o
+  CHECK   kernel/sched/completion.c
+  CC      kernel/sched/completion.o
+  CHECK   kernel/sched/cpupri.c
+  CC      kernel/sched/cpupri.o
+  CHECK   kernel/sched/cpudeadline.c
+  CC      kernel/sched/cpudeadline.o
+  CHECK   kernel/sched/topology.c
+kernel/sched/topology.c:91:56: warning: incorrect type in argument 1 (different address spaces)
+kernel/sched/topology.c:91:56:    expected struct sched_domain *sd
+kernel/sched/topology.c:91:56:    got struct sched_domain [noderef] <asn:4> *child
+kernel/sched/topology.c:110:60: warning: incorrect type in argument 1 (different address spaces)
+kernel/sched/topology.c:110:60:    expected struct sched_domain *sd
+kernel/sched/topology.c:110:60:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/topology.c:133:20: warning: incorrect type in assignment (different address spaces)
+kernel/sched/topology.c:133:20:    expected struct sched_domain *sd
+kernel/sched/topology.c:133:20:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/topology.c:207:1: warning: symbol 'sched_energy_mutex' was not declared. Should it be static?
+kernel/sched/topology.c:208:6: warning: symbol 'sched_energy_update' was not declared. Should it be static?
+kernel/sched/topology.c:406:13: warning: incorrect type in assignment (different address spaces)
+kernel/sched/topology.c:406:13:    expected struct perf_domain *[assigned] tmp
+kernel/sched/topology.c:406:13:    got struct perf_domain [noderef] <asn:4> *pd
+kernel/sched/topology.c:415:13: warning: incorrect type in assignment (different address spaces)
+kernel/sched/topology.c:415:13:    expected struct perf_domain *[assigned] tmp
+kernel/sched/topology.c:415:13:    got struct perf_domain [noderef] <asn:4> *pd
+kernel/sched/topology.c:436:19: warning: incorrect type in argument 1 (different address spaces)
+kernel/sched/topology.c:436:19:    expected struct perf_domain *[assigned] pd
+kernel/sched/topology.c:436:19:    got struct perf_domain [noderef] <asn:4> *pd
+kernel/sched/topology.c:597:49: warning: incorrect type in initializer (different address spaces)
+kernel/sched/topology.c:597:49:    expected struct sched_domain *parent
+kernel/sched/topology.c:597:49:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/sched.h:1355:9: warning: incorrect type in assignment (different address spaces)
+kernel/sched/sched.h:1355:9:    expected struct sched_domain *[assigned] sd
+kernel/sched/sched.h:1355:9:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/sched.h:1368:9: warning: incorrect type in assignment (different address spaces)
+kernel/sched/sched.h:1368:9:    expected struct sched_domain *[assigned] sd
+kernel/sched/sched.h:1368:9:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/sched.h:1355:9: warning: incorrect type in assignment (different address spaces)
+kernel/sched/sched.h:1355:9:    expected struct sched_domain *[assigned] sd
+kernel/sched/sched.h:1355:9:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/sched.h:1368:9: warning: incorrect type in assignment (different address spaces)
+kernel/sched/sched.h:1368:9:    expected struct sched_domain *[assigned] sd
+kernel/sched/sched.h:1368:9:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/topology.c:668:50: warning: incorrect type in initializer (different address spaces)
+kernel/sched/topology.c:668:50:    expected struct sched_domain *parent
+kernel/sched/topology.c:668:50:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/topology.c:675:55: warning: incorrect type in assignment (different address spaces)
+kernel/sched/topology.c:675:55:    expected struct sched_domain [noderef] <asn:4> *[noderef] <asn:4> child
+kernel/sched/topology.c:675:55:    got struct sched_domain *[assigned] tmp
+kernel/sched/topology.c:685:29: warning: incorrect type in assignment (different address spaces)
+kernel/sched/topology.c:685:29:    expected struct sched_domain *[assigned] tmp
+kernel/sched/topology.c:685:29:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/topology.c:690:20: warning: incorrect type in assignment (different address spaces)
+kernel/sched/topology.c:690:20:    expected struct sched_domain *sd
+kernel/sched/topology.c:690:20:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/topology.c:699:13: warning: incorrect type in assignment (different address spaces)
+kernel/sched/topology.c:699:13:    expected struct sched_domain *[assigned] tmp
+kernel/sched/topology.c:699:13:    got struct sched_domain [noderef] <asn:4> *sd
+kernel/sched/topology.c:861:70: warning: incorrect type in argument 1 (different address spaces)
+kernel/sched/topology.c:861:70:    expected struct sched_domain *sd
+kernel/sched/topology.c:861:70:    got struct sched_domain [noderef] <asn:4> *child
+kernel/sched/topology.c:890:59: warning: incorrect type in argument 1 (different address spaces)
+kernel/sched/topology.c:890:59:    expected struct sched_domain *sd
+kernel/sched/topology.c:890:59:    got struct sched_domain [noderef] <asn:4> *child
+kernel/sched/topology.c:1060:40: warning: incorrect type in initializer (different address spaces)
+kernel/sched/topology.c:1060:40:    expected struct sched_domain *child
+kernel/sched/topology.c:1060:40:    got struct sched_domain [noderef] <asn:4> *child
+kernel/sched/topology.c:1364:43: warning: incorrect type in initializer (different address spaces)
+kernel/sched/topology.c:1364:43:    expected struct sched_domain [noderef] <asn:4> *child
+kernel/sched/topology.c:1364:43:    got struct sched_domain *child
+kernel/sched/topology.c:1386:17: warning: incorrect type in assignment (different address spaces)
+kernel/sched/topology.c:1386:17:    expected struct sched_domain *t
+kernel/sched/topology.c:1386:17:    got struct sched_domain [noderef] <asn:4> *child
+kernel/sched/topology.c:1861:31: warning: incorrect type in assignment (different address spaces)
+kernel/sched/topology.c:1861:31:    expected struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/topology.c:1861:31:    got struct sched_domain *sd
+kernel/sched/topology.c:1991:57: warning: incorrect type in assignment (different address spaces)
+kernel/sched/topology.c:1991:57:    expected struct sched_domain *[assigned] sd
+kernel/sched/topology.c:1991:57:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/topology.c:2008:57: warning: incorrect type in assignment (different address spaces)
+kernel/sched/topology.c:2008:57:    expected struct sched_domain *[assigned] sd
+kernel/sched/topology.c:2008:57:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/topology.c:1384:27: warning: dereference of noderef expression
+  CC      kernel/sched/topology.o
+  CHECK   kernel/sched/stop_task.c
+  CC      kernel/sched/stop_task.o
+  CHECK   kernel/sched/pelt.c
+  CC      kernel/sched/pelt.o
+  CHECK   kernel/sched/autogroup.c
+kernel/sched/autogroup.c:144:9: warning: context imbalance in 'autogroup_move_group' - different lock contexts for basic block
+  CC      kernel/sched/autogroup.o
+  CHECK   kernel/sched/stats.c
+kernel/sched/stats.c:45:17: warning: incorrect type in assignment (different address spaces)
+kernel/sched/stats.c:45:17:    expected struct sched_domain *[assigned] sd
+kernel/sched/stats.c:45:17:    got struct sched_domain [noderef] <asn:4> *parent
+  CC      kernel/sched/stats.o
+  CHECK   kernel/sched/debug.c
+kernel/sched/debug.c:276:9: warning: incorrect type in assignment (different address spaces)
+kernel/sched/debug.c:276:9:    expected struct sched_domain *[assigned] sd
+kernel/sched/debug.c:276:9:    got struct sched_domain [noderef] <asn:4> *parent
+kernel/sched/debug.c:283:9: warning: incorrect type in assignment (different address spaces)
+kernel/sched/debug.c:283:9:    expected struct sched_domain *[assigned] sd
+kernel/sched/debug.c:283:9:    got struct sched_domain [noderef] <asn:4> *parent
+  CC      kernel/sched/debug.o
+  CHECK   kernel/sched/cpuacct.c
+  CC      kernel/sched/cpuacct.o
+  CHECK   kernel/sched/cpufreq.c
+  CC      kernel/sched/cpufreq.o
+  CHECK   kernel/sched/cpufreq_schedutil.c
+kernel/sched/cpufreq_schedutil.c:636:25: warning: symbol 'schedutil_gov' was not declared. Should it be static?
+  CC      kernel/sched/cpufreq_schedutil.o
+  CHECK   kernel/sched/membarrier.c
+kernel/sched/membarrier.c:108:21: error: incompatible types in comparison expression (different address spaces):
+kernel/sched/membarrier.c:108:21:    struct task_struct [noderef] <asn:4> *
+kernel/sched/membarrier.c:108:21:    struct task_struct *
+kernel/sched/membarrier.c:177:21: error: incompatible types in comparison expression (different address spaces):
+kernel/sched/membarrier.c:177:21:    struct task_struct [noderef] <asn:4> *
+kernel/sched/membarrier.c:177:21:    struct task_struct *
+kernel/sched/membarrier.c:243:21: error: incompatible types in comparison expression (different address spaces):
+kernel/sched/membarrier.c:243:21:    struct task_struct [noderef] <asn:4> *
+kernel/sched/membarrier.c:243:21:    struct task_struct *
+  CC      kernel/sched/membarrier.o
+  CHECK   kernel/sched/isolation.c
+  CC      kernel/sched/isolation.o
+  CHECK   kernel/sched/psi.c
+kernel/sched/psi.c:1155:9: error: incompatible types in comparison expression (different address spaces):
+kernel/sched/psi.c:1155:9:    void [noderef] <asn:4> *
+kernel/sched/psi.c:1155:9:    void *
+kernel/sched/psi.c:728:30: warning: dereference of noderef expression
+  CC      kernel/sched/psi.o
+  AR      kernel/sched/built-in.a
+  CHECK   kernel/time/time.c
+  CC      kernel/time/time.o
+  CHECK   kernel/time/timer.c
+  CC      kernel/time/timer.o
+  CHECK   kernel/time/hrtimer.c
+kernel/time/hrtimer.c:161:27: warning: context imbalance in 'lock_hrtimer_base' - wrong count at exit
+kernel/time/hrtimer.c:898:9: warning: context imbalance in 'hrtimer_start_range_ns' - unexpected unlock
+kernel/time/hrtimer.c:1168:28: warning: context imbalance in 'hrtimer_try_to_cancel' - unexpected unlock
+kernel/time/hrtimer.c:1289:9: warning: context imbalance in '__hrtimer_get_remaining' - unexpected unlock
+kernel/time/hrtimer.c:1484:25: warning: context imbalance in '__run_hrtimer' - unexpected unlock
+  CC      kernel/time/hrtimer.o
+  CHECK   kernel/time/timekeeping.c
+  CC      kernel/time/timekeeping.o
+  CHECK   kernel/time/ntp.c
+  CC      kernel/time/ntp.o
+  CHECK   kernel/time/clocksource.c
+  CC      kernel/time/clocksource.o
+  CHECK   kernel/time/jiffies.c
+  CC      kernel/time/jiffies.o
+  CHECK   kernel/time/timer_list.c
+  CC      kernel/time/timer_list.o
+  CHECK   kernel/time/timeconv.c
+  CC      kernel/time/timeconv.o
+  CHECK   kernel/time/timecounter.c
+  CC      kernel/time/timecounter.o
+  CHECK   kernel/time/alarmtimer.c
+  CC      kernel/time/alarmtimer.o
+  CHECK   kernel/time/posix-timers.c
+kernel/time/posix-timers.c:588:24: warning: context imbalance in '__lock_timer' - different lock contexts for basic block
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'timer_wait_running' - unexpected unlock
+kernel/time/posix-timers.c:876:12: warning: context imbalance in 'do_timer_settime' - different lock contexts for basic block
+kernel/time/posix-timers.c:982:1: warning: context imbalance in '__se_sys_timer_delete' - different lock contexts for basic block
+  CC      kernel/time/posix-timers.o
+  CHECK   kernel/time/posix-cpu-timers.c
+  CC      kernel/time/posix-cpu-timers.o
+  CHECK   kernel/time/posix-clock.c
+  CC      kernel/time/posix-clock.o
+  CHECK   kernel/time/itimer.c
+  CC      kernel/time/itimer.o
+  CHECK   kernel/time/clockevents.c
+  CC      kernel/time/clockevents.o
+  CHECK   kernel/time/tick-common.c
+  CC      kernel/time/tick-common.o
+  CHECK   kernel/time/tick-broadcast.c
+  CC      kernel/time/tick-broadcast.o
+  CHECK   kernel/time/tick-broadcast-hrtimer.c
+  CC      kernel/time/tick-broadcast-hrtimer.o
+  CHECK   kernel/time/tick-oneshot.c
+  CC      kernel/time/tick-oneshot.o
+  CHECK   kernel/time/tick-sched.c
+  CC      kernel/time/tick-sched.o
+  CHECK   kernel/time/vsyscall.c
+  CC      kernel/time/vsyscall.o
+  CHECK   kernel/time/timekeeping_debug.c
+  CC      kernel/time/timekeeping_debug.o
+  AR      kernel/time/built-in.a
+  CHECK   kernel/time/test_udelay.c
+  CC [M]  kernel/time/test_udelay.o
+  CHECK   kernel/trace/trace_selftest_dynamic.c
+  CC      kernel/trace/trace_selftest_dynamic.o
+  CHECK   kernel/trace/trace_kprobe_selftest.c
+kernel/trace/trace_kprobe_selftest.c:7:5: warning: symbol 'kprobe_trace_selftest_target' was not declared. Should it be static?
+  CC      kernel/trace/trace_kprobe_selftest.o
+  CHECK   kernel/trace/trace_clock.c
+  CC      kernel/trace/trace_clock.o
+  CHECK   kernel/trace/ftrace.c
+kernel/trace/ftrace.c:94:19: warning: symbol 'function_trace_op' was not declared. Should it be static?
+kernel/trace/ftrace.c:120:59: warning: incorrect type in initializer (different address spaces)
+kernel/trace/ftrace.c:120:59:    expected struct ftrace_ops [noderef] <asn:4> *[addressable] [toplevel] ftrace_ops_list
+kernel/trace/ftrace.c:120:59:    got struct ftrace_ops *
+kernel/trace/ftrace.c:208:49: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/ftrace.c:208:49:    expected struct ftrace_ops *ops
+kernel/trace/ftrace.c:208:49:    got struct ftrace_ops [noderef] <asn:4> *[addressable] [toplevel] ftrace_ops_list
+kernel/trace/ftrace.c:291:23: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:291:23:    expected struct ftrace_ops [noderef] <asn:4> *
+kernel/trace/ftrace.c:291:23:    got struct ftrace_ops *
+kernel/trace/ftrace.c:295:16: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:295:16:    expected struct ftrace_ops **p
+kernel/trace/ftrace.c:295:16:    got struct ftrace_ops [noderef] <asn:4> **list
+kernel/trace/ftrace.c:295:50: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:295:50:    expected struct ftrace_ops **p
+kernel/trace/ftrace.c:295:50:    got struct ftrace_ops [noderef] <asn:4> **
+kernel/trace/ftrace.c:302:12: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:302:12:    expected struct ftrace_ops *
+kernel/trace/ftrace.c:302:12:    got struct ftrace_ops [noderef] <asn:4> *next
+kernel/trace/ftrace.c:308:5: warning: symbol '__register_ftrace_function' was not declared. Should it be static?
+kernel/trace/ftrace.c:349:5: warning: symbol '__unregister_ftrace_function' was not declared. Should it be static?
+kernel/trace/ftrace.c:588:5: warning: symbol 'ftrace_profile_pages_init' was not declared. Should it be static?
+kernel/trace/ftrace.c:1049:43: warning: incorrect type in initializer (different address spaces)
+kernel/trace/ftrace.c:1049:43:    expected struct ftrace_hash [noderef] <asn:4> *notrace_hash
+kernel/trace/ftrace.c:1049:43:    got struct ftrace_hash *
+kernel/trace/ftrace.c:1050:43: warning: incorrect type in initializer (different address spaces)
+kernel/trace/ftrace.c:1050:43:    expected struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:1050:43:    got struct ftrace_hash *
+kernel/trace/ftrace.c:1272:40: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/ftrace.c:1272:40:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:1272:40:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:1273:40: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/ftrace.c:1273:40:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:1273:40:    got struct ftrace_hash [noderef] <asn:4> *notrace_hash
+kernel/trace/ftrace.c:1941:54: warning: incorrect type in initializer (different address spaces)
+kernel/trace/ftrace.c:1941:54:    expected struct ftrace_hash *old_hash
+kernel/trace/ftrace.c:1941:54:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:1449:9: error: incompatible types in comparison expression (different address spaces):
+kernel/trace/ftrace.c:1449:9:    struct ftrace_hash [noderef] <asn:4> *
+kernel/trace/ftrace.c:1449:9:    struct ftrace_hash *
+kernel/trace/ftrace.c:1465:39: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/ftrace.c:1465:39:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:1465:39:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:1466:40: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/ftrace.c:1466:40:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:1466:40:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:1467:40: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/ftrace.c:1467:40:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:1467:40:    got struct ftrace_hash [noderef] <asn:4> *notrace_hash
+kernel/trace/ftrace.c:1468:42: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/ftrace.c:1468:42:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:1468:42:    got struct ftrace_hash [noderef] <asn:4> *notrace_hash
+kernel/trace/ftrace.c:1612:18: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:1612:18:    expected struct ftrace_ops *ops
+kernel/trace/ftrace.c:1612:18:    got struct ftrace_ops [noderef] <asn:4> *[addressable] [toplevel] ftrace_ops_list
+kernel/trace/ftrace.c:1613:43: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:1613:43:    expected struct ftrace_ops *ops
+kernel/trace/ftrace.c:1613:43:    got struct ftrace_ops [noderef] <asn:4> *next
+kernel/trace/ftrace.c:1659:22: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:1659:22:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:1659:22:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:1660:28: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:1660:28:    expected struct ftrace_hash *other_hash
+kernel/trace/ftrace.c:1660:28:    got struct ftrace_hash [noderef] <asn:4> *notrace_hash
+kernel/trace/ftrace.c:1665:22: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:1665:22:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:1665:22:    got struct ftrace_hash [noderef] <asn:4> *notrace_hash
+kernel/trace/ftrace.c:1666:28: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:1666:28:    expected struct ftrace_hash *other_hash
+kernel/trace/ftrace.c:1666:28:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:1919:50: warning: incorrect type in initializer (different address spaces)
+kernel/trace/ftrace.c:1919:50:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:1919:50:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:1930:50: warning: incorrect type in initializer (different address spaces)
+kernel/trace/ftrace.c:1930:50:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:1930:50:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:3098:14: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:3098:14:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:3098:14:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:3115:22: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:3115:22:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:3115:22:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:3582:22: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:3582:22:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:3582:22:    got struct ftrace_hash [noderef] <asn:4> *notrace_hash
+kernel/trace/ftrace.c:3585:22: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:3585:22:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:3585:22:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:3671:6: warning: symbol 'arch_ftrace_match_adjust' was not declared. Should it be static?
+kernel/trace/ftrace.c:3987:27: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:3987:27:    expected struct ftrace_hash **orig_hash
+kernel/trace/ftrace.c:3987:27:    got struct ftrace_hash [noderef] <asn:4> **
+kernel/trace/ftrace.c:3989:27: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:3989:27:    expected struct ftrace_hash **orig_hash
+kernel/trace/ftrace.c:3989:27:    got struct ftrace_hash [noderef] <asn:4> **
+kernel/trace/ftrace.c:4361:19: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:4361:19:    expected struct ftrace_hash **orig_hash
+kernel/trace/ftrace.c:4361:19:    got struct ftrace_hash [noderef] <asn:4> **
+kernel/trace/ftrace.c:4503:19: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:4503:19:    expected struct ftrace_hash **orig_hash
+kernel/trace/ftrace.c:4503:19:    got struct ftrace_hash [noderef] <asn:4> **
+kernel/trace/ftrace.c:4509:34: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:4509:34:    expected struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:4509:34:    got struct ftrace_hash *[assigned] old_hash
+kernel/trace/ftrace.c:4761:27: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:4761:27:    expected struct ftrace_hash **orig_hash
+kernel/trace/ftrace.c:4761:27:    got struct ftrace_hash [noderef] <asn:4> **
+kernel/trace/ftrace.c:4763:27: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:4763:27:    expected struct ftrace_hash **orig_hash
+kernel/trace/ftrace.c:4763:27:    got struct ftrace_hash [noderef] <asn:4> **
+kernel/trace/ftrace.c:5047:35: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:5047:35:    expected struct ftrace_hash **orig_hash
+kernel/trace/ftrace.c:5047:35:    got struct ftrace_hash [noderef] <asn:4> **
+kernel/trace/ftrace.c:5051:35: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:5051:35:    expected struct ftrace_hash **orig_hash
+kernel/trace/ftrace.c:5051:35:    got struct ftrace_hash [noderef] <asn:4> **
+kernel/trace/ftrace.c:5170:29: error: incompatible types in comparison expression (different address spaces):
+kernel/trace/ftrace.c:5170:29:    struct ftrace_hash [noderef] <asn:4> *
+kernel/trace/ftrace.c:5170:29:    struct ftrace_hash *
+kernel/trace/ftrace.c:5173:29: error: incompatible types in comparison expression (different address spaces):
+kernel/trace/ftrace.c:5173:29:    struct ftrace_hash [noderef] <asn:4> *
+kernel/trace/ftrace.c:5173:29:    struct ftrace_hash *
+kernel/trace/ftrace.c:5291:21: error: incompatible types in comparison expression (different address spaces):
+kernel/trace/ftrace.c:5291:21:    struct ftrace_hash [noderef] <asn:4> *
+kernel/trace/ftrace.c:5291:21:    struct ftrace_hash *
+kernel/trace/ftrace.c:5319:21: error: incompatible types in comparison expression (different address spaces):
+kernel/trace/ftrace.c:5319:21:    struct ftrace_hash [noderef] <asn:4> *
+kernel/trace/ftrace.c:5319:21:    struct ftrace_hash *
+kernel/trace/ftrace.c:5370:36: error: incompatible types in comparison expression (different address spaces):
+kernel/trace/ftrace.c:5370:36:    struct ftrace_hash [noderef] <asn:4> *
+kernel/trace/ftrace.c:5370:36:    struct ftrace_hash *
+kernel/trace/ftrace.c:5372:25: error: incompatible types in comparison expression (different address spaces):
+kernel/trace/ftrace.c:5372:25:    struct ftrace_hash [noderef] <asn:4> *
+kernel/trace/ftrace.c:5372:25:    struct ftrace_hash *
+kernel/trace/ftrace.c:5374:36: error: incompatible types in comparison expression (different address spaces):
+kernel/trace/ftrace.c:5374:36:    struct ftrace_hash [noderef] <asn:4> *
+kernel/trace/ftrace.c:5374:36:    struct ftrace_hash *
+kernel/trace/ftrace.c:5376:25: error: incompatible types in comparison expression (different address spaces):
+kernel/trace/ftrace.c:5376:25:    struct ftrace_hash [noderef] <asn:4> *
+kernel/trace/ftrace.c:5376:25:    struct ftrace_hash *
+kernel/trace/ftrace.c:5694:18: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:5694:18:    expected struct ftrace_ops *ops
+kernel/trace/ftrace.c:5694:18:    got struct ftrace_ops [noderef] <asn:4> *[addressable] [toplevel] ftrace_ops_list
+kernel/trace/ftrace.c:2871:48: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/ftrace.c:2871:48:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:2871:48:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:2872:49: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/ftrace.c:2872:49:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:2872:49:    got struct ftrace_hash [noderef] <asn:4> *notrace_hash
+kernel/trace/ftrace.c:2894:46: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/ftrace.c:2894:46:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:2894:46:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:2895:47: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/ftrace.c:2895:47:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:2895:47:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:2899:44: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/ftrace.c:2899:44:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:2899:44:    got struct ftrace_hash [noderef] <asn:4> *notrace_hash
+kernel/trace/ftrace.c:5694:66: warning: incorrect type in assignment (different address spaces)
+kernel/trace/ftrace.c:5694:66:    expected struct ftrace_ops *ops
+kernel/trace/ftrace.c:5694:66:    got struct ftrace_ops [noderef] <asn:4> *next
+kernel/trace/ftrace.c:5735:59: warning: incorrect type in argument 2 (different address spaces)
+kernel/trace/ftrace.c:5735:59:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:5735:59:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:5736:59: warning: incorrect type in argument 2 (different address spaces)
+kernel/trace/ftrace.c:5736:59:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:5736:59:    got struct ftrace_hash [noderef] <asn:4> *notrace_hash
+kernel/trace/ftrace.c:6089:62: warning: incorrect type in argument 2 (different address spaces)
+kernel/trace/ftrace.c:6089:62:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:6089:62:    got struct ftrace_hash [noderef] <asn:4> *filter_hash
+kernel/trace/ftrace.c:6090:62: warning: incorrect type in argument 2 (different address spaces)
+kernel/trace/ftrace.c:6090:62:    expected struct ftrace_hash *hash
+kernel/trace/ftrace.c:6090:62:    got struct ftrace_hash [noderef] <asn:4> *notrace_hash
+kernel/trace/ftrace.c:6136:36: error: incompatible types in comparison expression (different address spaces):
+kernel/trace/ftrace.c:6136:36:    struct ftrace_ops [noderef] <asn:4> *
+kernel/trace/ftrace.c:6136:36:    struct ftrace_ops *
+kernel/trace/ftrace.c:206:20: warning: dereference of noderef expression
+kernel/trace/ftrace.c:206:20: warning: dereference of noderef expression
+kernel/trace/ftrace.c:206:20: warning: dereference of noderef expression
+  CC      kernel/trace/ftrace.o
+  CHECK   kernel/trace/ring_buffer.c
+kernel/trace/ring_buffer.c:696:32: warning: incorrect type in return expression (different base types)
+kernel/trace/ring_buffer.c:696:32:    expected restricted __poll_t
+kernel/trace/ring_buffer.c:696:32:    got int
+kernel/trace/ring_buffer.c:4097:9: warning: context imbalance in 'ring_buffer_peek' - different lock contexts for basic block
+kernel/trace/ring_buffer.c:4169:9: warning: context imbalance in 'ring_buffer_consume' - different lock contexts for basic block
+kernel/trace/ring_buffer.c:4465:17: warning: context imbalance in 'ring_buffer_empty' - different lock contexts for basic block
+kernel/trace/ring_buffer.c:4495:9: warning: context imbalance in 'ring_buffer_empty_cpu' - different lock contexts for basic block
+  CC      kernel/trace/ring_buffer.o
+  CHECK   kernel/trace/trace.c
+kernel/trace/trace.c:4999:1: warning: trying to concatenate 10528-character string (8191 bytes max)
+kernel/trace/trace.c:919:6: warning: symbol 'tracing_snapshot_instance_cond' was not declared. Should it be static?
+kernel/trace/trace.h:1413:38: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/trace.h:1413:38:    expected struct event_filter *filter
+kernel/trace/trace.h:1413:38:    got struct event_filter [noderef] <asn:4> *filter
+kernel/trace/trace.c:2730:28: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/trace.c:2730:28:    expected struct trace_export **list
+kernel/trace/trace.c:2730:28:    got struct trace_export [noderef] <asn:4> **
+kernel/trace/trace.c:2682:9: error: incompatible types in comparison expression (different address spaces):
+kernel/trace/trace.c:2682:9:    struct trace_export [noderef] <asn:4> *
+kernel/trace/trace.c:2682:9:    struct trace_export *
+kernel/trace/trace.c:2744:33: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/trace.c:2744:33:    expected struct trace_export **list
+kernel/trace/trace.c:2744:33:    got struct trace_export [noderef] <asn:4> **
+kernel/trace/trace.c:2690:38: warning: incorrect type in assignment (different address spaces)
+kernel/trace/trace.c:2690:38:    expected struct trace_export **[assigned] p
+kernel/trace/trace.c:2690:38:    got struct trace_export [noderef] <asn:4> **
+kernel/trace/trace.c:2697:9: error: incompatible types in comparison expression (different address spaces):
+kernel/trace/trace.c:2697:9:    struct trace_export [noderef] <asn:4> *
+kernel/trace/trace.c:2697:9:    struct trace_export *
+kernel/trace/trace.c:2998:46: warning: incorrect type in initializer (different address spaces)
+kernel/trace/trace.c:2998:46:    expected void const [noderef] <asn:3> *__vpp_verify
+kernel/trace/trace.c:2998:46:    got struct trace_buffer_struct *
+kernel/trace/trace.c:3014:9: warning: incorrect type in initializer (different address spaces)
+kernel/trace/trace.c:3014:9:    expected void const [noderef] <asn:3> *__vpp_verify
+kernel/trace/trace.c:3014:9:    got int *
+kernel/trace/trace.c:3021:17: warning: incorrect type in assignment (different address spaces)
+kernel/trace/trace.c:3021:17:    expected struct trace_buffer_struct *buffers
+kernel/trace/trace.c:3021:17:    got struct trace_buffer_struct [noderef] <asn:3> *
+kernel/trace/trace.c:8354:20: warning: symbol 'trace_array_create' was not declared. Should it be static?
+kernel/trace/trace.c:8476:5: warning: symbol 'trace_array_destroy' was not declared. Should it be static?
+  CC      kernel/trace/trace.o
+  CHECK   kernel/trace/trace_output.c
+  CC      kernel/trace/trace_output.o
+  CHECK   kernel/trace/trace_seq.c
+  CC      kernel/trace/trace_seq.o
+  CHECK   kernel/trace/trace_stat.c
+  CC      kernel/trace/trace_stat.o
+  CHECK   kernel/trace/trace_printk.c
+  CC      kernel/trace/trace_printk.o
+  CHECK   kernel/trace/tracing_map.c
+kernel/trace/tracing_map.c:286:6: warning: symbol 'tracing_map_array_clear' was not declared. Should it be static?
+kernel/trace/tracing_map.c:297:6: warning: symbol 'tracing_map_array_free' was not declared. Should it be static?
+kernel/trace/tracing_map.c:319:26: warning: symbol 'tracing_map_array_alloc' was not declared. Should it be static?
+  CC      kernel/trace/tracing_map.o
+  CHECK   kernel/trace/trace_sched_switch.c
+  CC      kernel/trace/trace_sched_switch.o
+  CHECK   kernel/trace/trace_functions.c
+  CC      kernel/trace/trace_functions.o
+  CHECK   kernel/trace/trace_preemptirq.c
+  CC      kernel/trace/trace_preemptirq.o
+  CHECK   kernel/trace/trace_irqsoff.c
+  CC      kernel/trace/trace_irqsoff.o
+  CHECK   kernel/trace/trace_sched_wakeup.c
+  CC      kernel/trace/trace_sched_wakeup.o
+  CHECK   kernel/trace/trace_hwlat.c
+  CC      kernel/trace/trace_hwlat.o
+  CHECK   kernel/trace/trace_nop.c
+  CC      kernel/trace/trace_nop.o
+  CHECK   kernel/trace/trace_stack.c
+  CC      kernel/trace/trace_stack.o
+  CHECK   kernel/trace/trace_mmiotrace.c
+  CC      kernel/trace/trace_mmiotrace.o
+  CHECK   kernel/trace/trace_functions_graph.c
+  CC      kernel/trace/trace_functions_graph.o
+  CHECK   kernel/trace/blktrace.c
+kernel/trace/blktrace.c:969:50: warning: incorrect type in argument 7 (different base types)
+kernel/trace/blktrace.c:969:50:    expected int error
+kernel/trace/blktrace.c:969:50:    got restricted blk_status_t [usertype] bi_status
+kernel/trace/blktrace.c:1002:68: warning: incorrect type in argument 7 (different base types)
+kernel/trace/blktrace.c:1002:68:    expected int error
+kernel/trace/blktrace.c:1002:68:    got restricted blk_status_t [usertype] bi_status
+kernel/trace/blktrace.c:1212:16: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1212:16: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1212:16: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1212:16: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1212:16: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1212:16: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1212:16: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1212:16: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1212:16: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1212:16: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1219:32: warning: incorrect type in initializer (different base types)
+kernel/trace/blktrace.c:1219:32:    expected unsigned long long [usertype] sector_from
+kernel/trace/blktrace.c:1219:32:    got restricted __be64 const [usertype] sector_from
+kernel/trace/blktrace.c:1221:24: warning: incorrect type in assignment (different base types)
+kernel/trace/blktrace.c:1221:24:    expected restricted __be32 [usertype] device_from
+kernel/trace/blktrace.c:1221:24:    got unsigned int
+kernel/trace/blktrace.c:1222:24: warning: incorrect type in assignment (different base types)
+kernel/trace/blktrace.c:1222:24:    expected restricted __be32 [usertype] device_to
+kernel/trace/blktrace.c:1222:24:    got unsigned int
+kernel/trace/blktrace.c:1223:26: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1223:26: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1223:26: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1223:26: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1223:26: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1223:26: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1223:26: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1223:26: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1223:26: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1223:26: warning: cast to restricted __be64
+kernel/trace/blktrace.c:1223:24: warning: incorrect type in assignment (different base types)
+kernel/trace/blktrace.c:1223:24:    expected restricted __be64 [usertype] sector_from
+kernel/trace/blktrace.c:1223:24:    got unsigned long long
+kernel/trace/blktrace.c:1370:26: warning: restricted __be32 degrades to integer
+kernel/trace/blktrace.c:1370:48: warning: restricted __be32 degrades to integer
+kernel/trace/blktrace.c:1371:27: warning: cast from restricted __be64
+  CC      kernel/trace/blktrace.o
+  CHECK   kernel/trace/fgraph.c
+kernel/trace/fgraph.c:209:15: warning: symbol 'ftrace_return_to_handler' was not declared. Should it be static?
+kernel/trace/fgraph.c:325:6: warning: symbol 'ftrace_graph_sleep_time_control' was not declared. Should it be static?
+  CC      kernel/trace/fgraph.o
+  CHECK   kernel/trace/trace_events.c
+kernel/trace/trace_events.c:724:31: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/trace_events.c:724:31:    expected struct event_filter *filter
+kernel/trace/trace_events.c:724:31:    got struct event_filter [noderef] <asn:4> *filter
+kernel/trace/trace.h:1413:38: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/trace.h:1413:38:    expected struct event_filter *filter
+kernel/trace/trace.h:1413:38:    got struct event_filter [noderef] <asn:4> *filter
+  CC      kernel/trace/trace_events.o
+  CHECK   kernel/trace/trace_export.c
+kernel/trace/trace_entries.h:59:1: warning: symbol 'event_class_ftrace_function' was not declared. Should it be static?
+kernel/trace/trace_entries.h:59:1: warning: symbol '__event_function' was not declared. Should it be static?
+kernel/trace/trace_entries.h:77:1: warning: symbol 'event_class_ftrace_funcgraph_entry' was not declared. Should it be static?
+kernel/trace/trace_entries.h:77:1: warning: symbol '__event_funcgraph_entry' was not declared. Should it be static?
+kernel/trace/trace_entries.h:93:1: warning: symbol 'event_class_ftrace_funcgraph_exit' was not declared. Should it be static?
+kernel/trace/trace_entries.h:93:1: warning: symbol '__event_funcgraph_exit' was not declared. Should it be static?
+kernel/trace/trace_entries.h:129:1: warning: symbol 'event_class_ftrace_context_switch' was not declared. Should it be static?
+kernel/trace/trace_entries.h:129:1: warning: symbol '__event_context_switch' was not declared. Should it be static?
+kernel/trace/trace_entries.h:149:1: warning: symbol 'event_class_ftrace_wakeup' was not declared. Should it be static?
+kernel/trace/trace_entries.h:149:1: warning: symbol '__event_wakeup' was not declared. Should it be static?
+kernel/trace/trace_entries.h:171:1: warning: symbol 'event_class_ftrace_kernel_stack' was not declared. Should it be static?
+kernel/trace/trace_entries.h:171:1: warning: symbol '__event_kernel_stack' was not declared. Should it be static?
+kernel/trace/trace_entries.h:191:1: warning: symbol 'event_class_ftrace_user_stack' was not declared. Should it be static?
+kernel/trace/trace_entries.h:191:1: warning: symbol '__event_user_stack' was not declared. Should it be static?
+kernel/trace/trace_entries.h:214:1: warning: symbol 'event_class_ftrace_bprint' was not declared. Should it be static?
+kernel/trace/trace_entries.h:214:1: warning: symbol '__event_bprint' was not declared. Should it be static?
+kernel/trace/trace_entries.h:230:1: warning: symbol 'event_class_ftrace_print' was not declared. Should it be static?
+kernel/trace/trace_entries.h:230:1: warning: symbol '__event_print' was not declared. Should it be static?
+kernel/trace/trace_entries.h:247:1: warning: symbol 'event_class_ftrace_raw_data' was not declared. Should it be static?
+kernel/trace/trace_entries.h:247:1: warning: symbol '__event_raw_data' was not declared. Should it be static?
+kernel/trace/trace_entries.h:262:1: warning: symbol 'event_class_ftrace_bputs' was not declared. Should it be static?
+kernel/trace/trace_entries.h:262:1: warning: symbol '__event_bputs' was not declared. Should it be static?
+kernel/trace/trace_entries.h:277:1: warning: symbol 'event_class_ftrace_mmiotrace_rw' was not declared. Should it be static?
+kernel/trace/trace_entries.h:277:1: warning: symbol '__event_mmiotrace_rw' was not declared. Should it be static?
+kernel/trace/trace_entries.h:298:1: warning: symbol 'event_class_ftrace_mmiotrace_map' was not declared. Should it be static?
+kernel/trace/trace_entries.h:298:1: warning: symbol '__event_mmiotrace_map' was not declared. Should it be static?
+kernel/trace/trace_entries.h:322:1: warning: symbol 'event_class_ftrace_branch' was not declared. Should it be static?
+kernel/trace/trace_entries.h:322:1: warning: symbol '__event_branch' was not declared. Should it be static?
+kernel/trace/trace_entries.h:343:1: warning: symbol 'event_class_ftrace_hwlat' was not declared. Should it be static?
+kernel/trace/trace_entries.h:343:1: warning: symbol '__event_hwlat' was not declared. Should it be static?
+  CC      kernel/trace/trace_export.o
+  CHECK   kernel/trace/trace_syscalls.c
+kernel/trace/trace.h:1413:38: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/trace.h:1413:38:    expected struct event_filter *filter
+kernel/trace/trace.h:1413:38:    got struct event_filter [noderef] <asn:4> *filter
+kernel/trace/trace.h:1413:38: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/trace.h:1413:38:    expected struct event_filter *filter
+kernel/trace/trace.h:1413:38:    got struct event_filter [noderef] <asn:4> *filter
+  CC      kernel/trace/trace_syscalls.o
+  CHECK   kernel/trace/trace_event_perf.c
+  CC      kernel/trace/trace_event_perf.o
+  CHECK   kernel/trace/trace_events_filter.c
+kernel/trace/trace_events_filter.c:978:20: warning: incorrect type in return expression (different address spaces)
+kernel/trace/trace_events_filter.c:978:20:    expected struct event_filter *
+kernel/trace/trace_events_filter.c:978:20:    got struct event_filter [noderef] <asn:4> *filter
+kernel/trace/trace_events_filter.c:1048:34: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/trace_events_filter.c:1048:34:    expected struct event_filter *filter
+kernel/trace/trace_events_filter.c:1048:34:    got struct event_filter [noderef] <asn:4> *filter
+kernel/trace/trace_events_filter.c:1065:27: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/trace_events_filter.c:1065:27:    expected struct event_filter *filter
+kernel/trace/trace_events_filter.c:1065:27:    got struct event_filter [noderef] <asn:4> *filter
+kernel/trace/trace_events_filter.c:978:20: warning: incorrect type in return expression (different address spaces)
+kernel/trace/trace_events_filter.c:978:20:    expected struct event_filter *
+kernel/trace/trace_events_filter.c:978:20:    got struct event_filter [noderef] <asn:4> *filter
+kernel/trace/trace_events_filter.c:978:20: warning: incorrect type in return expression (different address spaces)
+kernel/trace/trace_events_filter.c:978:20:    expected struct event_filter *
+kernel/trace/trace_events_filter.c:978:20:    got struct event_filter [noderef] <asn:4> *filter
+kernel/trace/trace_events_filter.c:978:20: warning: incorrect type in return expression (different address spaces)
+kernel/trace/trace_events_filter.c:978:20:    expected struct event_filter *
+kernel/trace/trace_events_filter.c:978:20:    got struct event_filter [noderef] <asn:4> *filter
+  CC      kernel/trace/trace_events_filter.o
+  CHECK   kernel/trace/trace_events_trigger.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC      kernel/trace/trace_events_trigger.o
+  CHECK   kernel/trace/trace_events_hist.c
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+kernel/trace/trace_events_hist.c:849:29: warning: cast from restricted gfp_t
+  CC      kernel/trace/trace_events_hist.o
+  CHECK   kernel/trace/bpf_trace.c
+  CC      kernel/trace/bpf_trace.o
+  CHECK   kernel/trace/trace_kprobe.c
+kernel/trace/trace.h:1413:38: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/trace.h:1413:38:    expected struct event_filter *filter
+kernel/trace/trace.h:1413:38:    got struct event_filter [noderef] <asn:4> *filter
+kernel/trace/trace.h:1413:38: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/trace.h:1413:38:    expected struct event_filter *filter
+kernel/trace/trace.h:1413:38:    got struct event_filter [noderef] <asn:4> *filter
+  CC      kernel/trace/trace_kprobe.o
+  CHECK   kernel/trace/power-traces.c
+  CC      kernel/trace/power-traces.o
+  CHECK   kernel/trace/rpm-traces.c
+  CC      kernel/trace/rpm-traces.o
+  CHECK   kernel/trace/trace_kdb.c
+  CC      kernel/trace/trace_kdb.o
+  CHECK   kernel/trace/trace_dynevent.c
+  CC      kernel/trace/trace_dynevent.o
+  CHECK   kernel/trace/trace_probe.c
+  CC      kernel/trace/trace_probe.o
+  CHECK   kernel/trace/trace_uprobe.c
+kernel/trace/trace.h:1413:38: warning: incorrect type in argument 1 (different address spaces)
+kernel/trace/trace.h:1413:38:    expected struct event_filter *filter
+kernel/trace/trace.h:1413:38:    got struct event_filter [noderef] <asn:4> *filter
+  CC      kernel/trace/trace_uprobe.o
+  CHECK   kernel/trace/trace_benchmark.c
+  CC      kernel/trace/trace_benchmark.o
+  AR      kernel/trace/built-in.a
+  CHECK   kernel/trace/ring_buffer_benchmark.c
+  CC [M]  kernel/trace/ring_buffer_benchmark.o
+  CHECK   kernel/trace/preemptirq_delay_test.c
+  CC [M]  kernel/trace/preemptirq_delay_test.o
+  CHECK   kernel/kcmp.c
+kernel/kcmp.c:224:62: warning: incorrect type in argument 4 (different address spaces)
+kernel/kcmp.c:224:62:    expected struct kcmp_epoll_slot [noderef] <asn:1> *uslot
+kernel/kcmp.c:224:62:    got void *
+  CC      kernel/kcmp.o
+  CHECK   kernel/freezer.c
+  CC      kernel/freezer.o
+  CHECK   kernel/profile.c
+  CC      kernel/profile.o
+  CHECK   kernel/stacktrace.c
+  CC      kernel/stacktrace.o
+  CHECK   kernel/futex.c
+kernel/futex.c:1619:9: warning: context imbalance in 'wake_futex_pi' - unexpected unlock
+kernel/futex.c:1779:33: warning: context imbalance in 'futex_wake_op' - different lock contexts for basic block
+./include/linux/kasan-checks.h:38:20: warning: context imbalance in 'futex_requeue' - different lock contexts for basic block
+kernel/futex.c:2568:9: warning: context imbalance in 'fixup_pi_state_owner' - unexpected unlock
+kernel/futex.c:2677:13: warning: context imbalance in 'futex_wait_queue_me' - unexpected unlock
+kernel/futex.c:2779:1: warning: context imbalance in 'futex_wait_setup' - different lock contexts for basic block
+kernel/futex.c:3067:12: warning: context imbalance in 'futex_unlock_pi' - different lock contexts for basic block
+kernel/futex.c:3345:29: warning: context imbalance in 'futex_wait_requeue_pi' - unexpected unlock
+  CC      kernel/futex.o
+  CHECK   kernel/dma.c
+  CC      kernel/dma.o
+  CHECK   kernel/smp.c
+  CC      kernel/smp.o
+  CHECK   kernel/uid16.c
+  CC      kernel/uid16.o
+  CHECK   kernel/module.c
+kernel/module.c:1413:1: error: directive in macro's argument list
+kernel/module.c:1415:1: error: directive in macro's argument list
+./include/linux/rbtree.h:84:9: error: incompatible types in comparison expression (different address spaces):
+./include/linux/rbtree.h:84:9:    struct rb_node [noderef] <asn:4> *
+./include/linux/rbtree.h:84:9:    struct rb_node *
+./include/linux/rbtree.h:84:9: error: incompatible types in comparison expression (different address spaces):
+./include/linux/rbtree.h:84:9:    struct rb_node [noderef] <asn:4> *
+./include/linux/rbtree.h:84:9:    struct rb_node *
+kernel/module.c:3621:9: error: incompatible types in comparison expression (different address spaces):
+kernel/module.c:3621:9:    struct mod_kallsyms [noderef] <asn:4> *
+kernel/module.c:3621:9:    struct mod_kallsyms *
+kernel/module.c:4054:41: error: incompatible types in comparison expression (different address spaces):
+kernel/module.c:4054:41:    struct mod_kallsyms [noderef] <asn:4> *
+kernel/module.c:4054:41:    struct mod_kallsyms *
+kernel/module.c:4197:28: error: incompatible types in comparison expression (different address spaces):
+kernel/module.c:4197:28:    struct mod_kallsyms [noderef] <asn:4> *
+kernel/module.c:4197:28:    struct mod_kallsyms *
+kernel/module.c:4219:41: error: incompatible types in comparison expression (different address spaces):
+kernel/module.c:4219:41:    struct mod_kallsyms [noderef] <asn:4> *
+kernel/module.c:4219:41:    struct mod_kallsyms *
+  CC      kernel/module.o
+  CHECK   kernel/module_signing.c
+  CC      kernel/module_signing.o
+  CHECK   kernel/module_signature.c
+  CC      kernel/module_signature.o
+  CHECK   kernel/kallsyms.c
+kernel/kallsyms.c:450:12: warning: symbol 'arch_get_kallsym' was not declared. Should it be static?
+  CC      kernel/kallsyms.o
+  CHECK   kernel/acct.c
+kernel/acct.c:193:12: warning: context imbalance in 'acct_on' - different lock contexts for basic block
+kernel/acct.c:294:9: warning: context imbalance in '__se_sys_acct' - different lock contexts for basic block
+kernel/acct.c:299:22: warning: context imbalance in 'acct_exit_ns' - wrong count at exit
+  CC      kernel/acct.o
+  CHECK   kernel/crash_core.c
+  CC      kernel/crash_core.o
+  CHECK   kernel/kexec_core.c
+  CC      kernel/kexec_core.o
+  CHECK   kernel/kexec.c
+  CC      kernel/kexec.o
+  CHECK   kernel/kexec_file.c
+kernel/kexec_file.c:86:12: warning: symbol 'arch_kimage_file_post_load_cleanup' was not declared. Should it be static?
+kernel/kexec_file.c:103:12: warning: symbol 'arch_kexec_kernel_verify_sig' was not declared. Should it be static?
+  CC      kernel/kexec_file.o
+  CHECK   kernel/compat.c
+  CC      kernel/compat.o
+  CHECK   kernel/utsname.c
+  CC      kernel/utsname.o
+  CHECK   kernel/user_namespace.c
+  CC      kernel/user_namespace.o
+  CHECK   kernel/pid_namespace.c
+kernel/pid_namespace.c:54:76: warning: Using plain integer as NULL pointer
+  CC      kernel/pid_namespace.o
+  CHECK   kernel/stop_machine.c
+  CC      kernel/stop_machine.o
+  CHECK   kernel/test_kprobes.c
+  CC      kernel/test_kprobes.o
+  CHECK   kernel/audit.c
+kernel/audit.c:218:14: error: incompatible types in comparison expression (different address spaces):
+kernel/audit.c:218:14:    struct auditd_connection [noderef] <asn:4> *
+kernel/audit.c:218:14:    struct auditd_connection *
+kernel/audit.c:267:14: error: incompatible types in comparison expression (different address spaces):
+kernel/audit.c:267:14:    struct auditd_connection [noderef] <asn:4> *
+kernel/audit.c:267:14:    struct auditd_connection *
+kernel/audit.c:508:18: error: incompatible types in comparison expression (different address spaces):
+kernel/audit.c:508:18:    struct auditd_connection [noderef] <asn:4> *
+kernel/audit.c:508:18:    struct auditd_connection *
+kernel/audit.c:510:9: error: incompatible types in comparison expression (different address spaces):
+kernel/audit.c:510:9:    struct auditd_connection [noderef] <asn:4> *
+kernel/audit.c:510:9:    struct auditd_connection *
+kernel/audit.c:621:18: error: incompatible types in comparison expression (different address spaces):
+kernel/audit.c:621:18:    struct auditd_connection [noderef] <asn:4> *
+kernel/audit.c:621:18:    struct auditd_connection *
+kernel/audit.c:628:9: error: incompatible types in comparison expression (different address spaces):
+kernel/audit.c:628:9:    struct auditd_connection [noderef] <asn:4> *
+kernel/audit.c:628:9:    struct auditd_connection *
+kernel/audit.c:667:14: error: incompatible types in comparison expression (different address spaces):
+kernel/audit.c:667:14:    struct auditd_connection [noderef] <asn:4> *
+kernel/audit.c:667:14:    struct auditd_connection *
+kernel/audit.c:819:22: error: incompatible types in comparison expression (different address spaces):
+kernel/audit.c:819:22:    struct auditd_connection [noderef] <asn:4> *
+kernel/audit.c:819:22:    struct auditd_connection *
+  CC      kernel/audit.o
+  CHECK   kernel/auditfilter.c
+  CC      kernel/auditfilter.o
+  CHECK   kernel/auditsc.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC      kernel/auditsc.o
+  CHECK   kernel/audit_watch.c
+  CC      kernel/audit_watch.o
+  CHECK   kernel/audit_fsnotify.c
+  CC      kernel/audit_fsnotify.o
+  CHECK   kernel/audit_tree.c
+  CC      kernel/audit_tree.o
+  CHECK   kernel/kcov.c
+kernel/kcov.c:94:14: warning: symbol '__sanitizer_cov_trace_pc' was not declared. Should it be static?
+kernel/kcov.c:149:14: warning: symbol '__sanitizer_cov_trace_cmp1' was not declared. Should it be static?
+kernel/kcov.c:155:14: warning: symbol '__sanitizer_cov_trace_cmp2' was not declared. Should it be static?
+kernel/kcov.c:161:14: warning: symbol '__sanitizer_cov_trace_cmp4' was not declared. Should it be static?
+kernel/kcov.c:167:14: warning: symbol '__sanitizer_cov_trace_cmp8' was not declared. Should it be static?
+kernel/kcov.c:173:14: warning: symbol '__sanitizer_cov_trace_const_cmp1' was not declared. Should it be static?
+kernel/kcov.c:180:14: warning: symbol '__sanitizer_cov_trace_const_cmp2' was not declared. Should it be static?
+kernel/kcov.c:187:14: warning: symbol '__sanitizer_cov_trace_const_cmp4' was not declared. Should it be static?
+kernel/kcov.c:194:14: warning: symbol '__sanitizer_cov_trace_const_cmp8' was not declared. Should it be static?
+kernel/kcov.c:201:14: warning: symbol '__sanitizer_cov_trace_switch' was not declared. Should it be static?
+  CC      kernel/kcov.o
+  CHECK   kernel/kprobes.c
+  CC      kernel/kprobes.o
+  CHECK   kernel/fail_function.c
+  CC      kernel/fail_function.o
+  CHECK   kernel/hung_task.c
+  CC      kernel/hung_task.o
+  CHECK   kernel/watchdog.c
+  CC      kernel/watchdog.o
+  CHECK   kernel/watchdog_hld.c
+  CC      kernel/watchdog_hld.o
+  CHECK   kernel/seccomp.c
+  CC      kernel/seccomp.o
+  CHECK   kernel/relay.c
+  CC      kernel/relay.o
+  CHECK   kernel/utsname_sysctl.c
+  CC      kernel/utsname_sysctl.o
+  CHECK   kernel/delayacct.c
+  CC      kernel/delayacct.o
+  CHECK   kernel/taskstats.c
+  CC      kernel/taskstats.o
+  CHECK   kernel/tsacct.c
+  CC      kernel/tsacct.o
+  CHECK   kernel/tracepoint.c
+  CC      kernel/tracepoint.o
+  CHECK   kernel/latencytop.c
+  CC      kernel/latencytop.o
+  CHECK   kernel/elfcore.c
+  CC      kernel/elfcore.o
+  CHECK   kernel/irq_work.c
+  CC      kernel/irq_work.o
+  CHECK   kernel/user-return-notifier.c
+  CC      kernel/user-return-notifier.o
+  CHECK   kernel/padata.c
+kernel/padata.c:110:14: error: incompatible types in comparison expression (different address spaces):
+kernel/padata.c:110:14:    struct parallel_data [noderef] <asn:4> *
+kernel/padata.c:110:14:    struct parallel_data *
+kernel/padata.c:520:9: error: incompatible types in comparison expression (different address spaces):
+kernel/padata.c:520:9:    struct parallel_data [noderef] <asn:4> *
+kernel/padata.c:520:9:    struct parallel_data *
+kernel/padata.c:751:5: warning: symbol 'padata_remove_cpu' was not declared. Should it be static?
+kernel/padata.c:1000:9: error: incompatible types in comparison expression (different address spaces):
+kernel/padata.c:1000:9:    struct parallel_data [noderef] <asn:4> *
+kernel/padata.c:1000:9:    struct parallel_data *
+  CC      kernel/padata.o
+  CHECK   kernel/crash_dump.c
+  CC      kernel/crash_dump.o
+  CHECK   kernel/jump_label.c
+  CC      kernel/jump_label.o
+  CHECK   kernel/iomem.c
+kernel/iomem.c:113:22: warning: incorrect type in assignment (different address spaces)
+kernel/iomem.c:113:22:    expected void *[assigned] addr
+kernel/iomem.c:113:22:    got void [noderef] <asn:2> *
+kernel/iomem.c:116:22: warning: incorrect type in assignment (different address spaces)
+kernel/iomem.c:116:22:    expected void *[assigned] addr
+kernel/iomem.c:116:22:    got void [noderef] <asn:2> *
+  CC      kernel/iomem.o
+  CHECK   kernel/rseq.c
+  CC      kernel/rseq.o
+  AR      kernel/built-in.a
+  CHECK   kernel/backtracetest.c
+  CC [M]  kernel/backtracetest.o
+  CHECK   kernel/configs.c
+  CC [M]  kernel/configs.o
+  CHK     kernel/kheaders_data.tar.xz
+  GEN     kernel/kheaders_data.tar.xz
+  CHECK   kernel/kheaders.c
+  CC [M]  kernel/kheaders.o
+  CHECK   kernel/torture.c
+  CC [M]  kernel/torture.o
+  CHECK   certs/system_keyring.c
+  CC      certs/system_keyring.o
+  AS      certs/system_certificates.o
+  CHECK   certs/blacklist.c
+  CC      certs/blacklist.o
+  CHECK   certs/blacklist_nohashes.c
+  CC      certs/blacklist_nohashes.o
+  AR      certs/built-in.a
+  CHECK   mm/filemap.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC      mm/filemap.o
+  CHECK   mm/mempool.c
+  CC      mm/mempool.o
+  CHECK   mm/oom_kill.c
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'find_lock_task_mm' - wrong count at exit
+./include/linux/sched/mm.h:168:37: warning: dereference of noderef expression
+mm/oom_kill.c:219:28: warning: context imbalance in 'oom_badness' - unexpected unlock
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'dump_task' - unexpected unlock
+./include/linux/rcupdate.h:669:9: warning: context imbalance in '__oom_kill_process' - unexpected unlock
+  CC      mm/oom_kill.o
+  CHECK   mm/fadvise.c
+  CC      mm/fadvise.o
+  CHECK   mm/maccess.c
+  CC      mm/maccess.o
+  CHECK   mm/page-writeback.c
+./include/linux/rcupdate.h:667:9: warning: context imbalance in 'account_page_redirty' - different lock contexts for basic block
+./include/linux/rcupdate.h:667:9: warning: context imbalance in '__cancel_dirty_page' - different lock contexts for basic block
+./include/linux/rcupdate.h:667:9: warning: context imbalance in 'clear_page_dirty_for_io' - different lock contexts for basic block
+  CC      mm/page-writeback.o
+  CHECK   mm/readahead.c
+  CC      mm/readahead.o
+  CHECK   mm/swap.c
+mm/swap.c:205:55: warning: context imbalance in 'pagevec_lru_move_fn' - unexpected unlock
+  CC      mm/swap.o
+  CHECK   mm/truncate.c
+mm/truncate.c:104:9: warning: context imbalance in 'truncate_exceptional_pvec_entries' - different lock contexts for basic block
+  CC      mm/truncate.o
+  CHECK   mm/vmscan.c
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:75:1: warning: incorrect type in argument 3 (different base types)
+./include/trace/events/vmscan.h:75:1:    expected unsigned long flags
+./include/trace/events/vmscan.h:75:1:    got restricted gfp_t [usertype] gfp_flags
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:101:1: warning: incorrect type in argument 3 (different base types)
+./include/trace/events/vmscan.h:101:1:    expected unsigned long flags
+./include/trace/events/vmscan.h:101:1:    got restricted gfp_t [usertype] gfp_flags
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: cast from restricted gfp_t
+./include/trace/events/vmscan.h:185:1: warning: too many warnings
+  CC      mm/vmscan.o
+  CHECK   mm/shmem.c
+  CC      mm/shmem.o
+  CHECK   mm/util.c
+  CC      mm/util.o
+  CHECK   mm/mmzone.c
+  CC      mm/mmzone.o
+  CHECK   mm/vmstat.c
+mm/vmstat.c:1345:47: warning: context imbalance in 'walk_zones_in_node' - unexpected unlock
+  CC      mm/vmstat.o
+  CHECK   mm/backing-dev.c
+mm/backing-dev.c:720:9: warning: incorrect type in assignment (different address spaces)
+mm/backing-dev.c:720:9:    expected void **slot
+mm/backing-dev.c:720:9:    got void [noderef] <asn:4> **
+mm/backing-dev.c:720:9: warning: incorrect type in assignment (different address spaces)
+mm/backing-dev.c:720:9:    expected void **slot
+mm/backing-dev.c:720:9:    got void [noderef] <asn:4> **
+mm/backing-dev.c:720:9: warning: incorrect type in argument 1 (different address spaces)
+mm/backing-dev.c:720:9:    expected void [noderef] <asn:4> **slot
+mm/backing-dev.c:720:9:    got void **slot
+mm/backing-dev.c:720:9: warning: incorrect type in assignment (different address spaces)
+mm/backing-dev.c:720:9:    expected void **slot
+mm/backing-dev.c:720:9:    got void [noderef] <asn:4> **
+mm/backing-dev.c:476:31: warning: context imbalance in 'wb_congested_put' - unexpected unlock
+  CC      mm/backing-dev.o
+  CHECK   mm/mm_init.c
+mm/mm_init.c:141:5: warning: symbol 'vm_committed_as_batch' was not declared. Should it be static?
+  CC      mm/mm_init.o
+  CHECK   mm/mmu_context.c
+  CC      mm/mmu_context.o
+  CHECK   mm/percpu.c
+  CC      mm/percpu.o
+  CHECK   mm/slab_common.c
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:12:1: warning: incorrect type in argument 3 (different base types)
+./include/trace/events/kmem.h:12:1:    expected unsigned long flags
+./include/trace/events/kmem.h:12:1:    got restricted gfp_t [usertype] gfp_flags
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:62:1: warning: incorrect type in argument 3 (different base types)
+./include/trace/events/kmem.h:62:1:    expected unsigned long flags
+./include/trace/events/kmem.h:62:1:    got restricted gfp_t [usertype] gfp_flags
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: cast from restricted gfp_t
+./include/trace/events/kmem.h:193:1: warning: too many warnings
+  CC      mm/slab_common.o
+  CHECK   mm/compaction.c
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast from restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: incorrect type in argument 3 (different base types)
+./include/trace/events/compaction.h:170:1:    expected unsigned long flags
+./include/trace/events/compaction.h:170:1:    got restricted gfp_t [usertype] gfp_mask
+./include/trace/events/compaction.h:170:1: warning: cast to restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: cast to restricted gfp_t
+./include/trace/events/compaction.h:170:1: warning: restricted gfp_t degrades to integer
+./include/trace/events/compaction.h:170:1: warning: restricted gfp_t degrades to integer
+./include/linux/gfp.h:318:27: warning: restricted gfp_t degrades to integer
+mm/compaction.c:2343:39: warning: incorrect type in initializer (different base types)
+mm/compaction.c:2343:39:    expected int may_perform_io
+mm/compaction.c:2343:39:    got restricted gfp_t
+mm/compaction.c:482:13: warning: context imbalance in 'compact_lock_irqsave' - wrong count at exit
+./include/linux/spinlock.h:393:9: warning: context imbalance in 'compact_unlock_should_abort' - unexpected unlock
+mm/compaction.c:638:39: warning: context imbalance in 'isolate_freepages_block' - unexpected unlock
+mm/compaction.c:1047:39: warning: context imbalance in 'isolate_migratepages_block' - unexpected unlock
+  CC      mm/compaction.o
+  CHECK   mm/vmacache.c
+  CC      mm/vmacache.o
+  CHECK   mm/interval_tree.c
+  CC      mm/interval_tree.o
+  CHECK   mm/list_lru.c
+  CC      mm/list_lru.o
+  CHECK   mm/workingset.c
+  CC      mm/workingset.o
+  CHECK   mm/debug.c
+mm/debug.c:137:1: error: directive in macro's argument list
+mm/debug.c:139:1: error: directive in macro's argument list
+mm/debug.c:148:1: error: directive in macro's argument list
+mm/debug.c:150:1: error: directive in macro's argument list
+mm/debug.c:151:1: error: directive in macro's argument list
+mm/debug.c:153:1: error: directive in macro's argument list
+mm/debug.c:155:1: error: directive in macro's argument list
+mm/debug.c:157:1: error: directive in macro's argument list
+mm/debug.c:158:1: error: directive in macro's argument list
+mm/debug.c:160:1: error: directive in macro's argument list
+mm/debug.c:165:1: error: directive in macro's argument list
+mm/debug.c:167:1: error: directive in macro's argument list
+mm/debug.c:180:1: error: directive in macro's argument list
+mm/debug.c:182:1: error: directive in macro's argument list
+mm/debug.c:183:1: error: directive in macro's argument list
+mm/debug.c:185:1: error: directive in macro's argument list
+mm/debug.c:187:1: error: directive in macro's argument list
+mm/debug.c:189:1: error: directive in macro's argument list
+mm/debug.c:190:1: error: directive in macro's argument list
+mm/debug.c:192:1: error: directive in macro's argument list
+  CC      mm/debug.o
+  CHECK   mm/gup.c
+  CC      mm/gup.o
+  CHECK   mm/highmem.c
+  CC      mm/highmem.o
+  CHECK   mm/memory.c
+mm/memory.c:140:15: warning: symbol 'zero_pfn' was not declared. Should it be static?
+mm/memory.c:4677:22: warning: cast removes address space '<asn:1>' of expression
+mm/memory.c:812:17: warning: context imbalance in 'copy_pte_range' - different lock contexts for basic block
+mm/memory.c:1424:16: warning: context imbalance in '__get_locked_pte' - different lock contexts for basic block
+mm/memory.c:1813:17: warning: context imbalance in 'remap_pte_range' - different lock contexts for basic block
+mm/memory.c:2043:17: warning: context imbalance in 'apply_to_pte_range' - unexpected unlock
+mm/memory.c:2559:17: warning: context imbalance in 'wp_pfn_shared' - unexpected unlock
+mm/memory.c:2621:19: warning: context imbalance in 'do_wp_page' - different lock contexts for basic block
+mm/memory.c:3198:19: warning: context imbalance in 'pte_alloc_one_map' - different lock contexts for basic block
+mm/memory.c:3428:17: warning: context imbalance in 'finish_fault' - unexpected unlock
+mm/memory.c:3537:9: warning: context imbalance in 'do_fault_around' - unexpected unlock
+mm/memory.c:4190:12: warning: context imbalance in '__follow_pte_pmd' - different lock contexts for basic block
+mm/memory.c:4269:5: warning: context imbalance in 'follow_pte_pmd' - different lock contexts for basic block
+  CC      mm/memory.o
+  CHECK   mm/mincore.c
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'mincore_page' - unexpected unlock
+mm/mincore.c:133:17: warning: context imbalance in 'mincore_pte_range' - unexpected unlock
+  CC      mm/mincore.o
+  CHECK   mm/mlock.c
+./include/linux/mm.h:1740:21: warning: context imbalance in '__munlock_pagevec_fill' - different lock contexts for basic block
+  CC      mm/mlock.o
+  CHECK   mm/mmap.c
+  CC      mm/mmap.o
+  CHECK   mm/mmu_gather.c
+  CC      mm/mmu_gather.o
+  CHECK   mm/mprotect.c
+  CC      mm/mprotect.o
+  CHECK   mm/mremap.c
+mm/mremap.c:189:9: warning: context imbalance in 'move_ptes' - different lock contexts for basic block
+mm/mremap.c:234:20: warning: context imbalance in 'move_normal_pmd' - different lock contexts for basic block
+  CC      mm/mremap.o
+  CHECK   mm/msync.c
+  CC      mm/msync.o
+  CHECK   mm/page_vma_mapped.c
+mm/page_vma_mapped.c:16:13: warning: context imbalance in 'map_pte' - wrong count at exit
+./include/linux/rmap.h:220:28: warning: context imbalance in 'page_vma_mapped_walk' - unexpected unlock
+./include/linux/rmap.h:220:28: warning: context imbalance in 'page_mapped_in_vma' - unexpected unlock
+  CC      mm/page_vma_mapped.o
+  CHECK   mm/pagewalk.c
+mm/pagewalk.c:99:33: warning: context imbalance in 'walk_pud_range' - unexpected unlock
+  CC      mm/pagewalk.o
+  CHECK   mm/pgtable-generic.c
+  CC      mm/pgtable-generic.o
+  CHECK   mm/rmap.c
+./include/linux/rmap.h:220:28: warning: context imbalance in 'page_referenced_one' - unexpected unlock
+./include/linux/rmap.h:220:28: warning: context imbalance in 'try_to_unmap_one' - unexpected unlock
+  CC      mm/rmap.o
+  CHECK   mm/vmalloc.c
+  CC      mm/vmalloc.o
+  CHECK   mm/process_vm_access.c
+  CC      mm/process_vm_access.o
+  CHECK   mm/page_alloc.c
+mm/page_alloc.c:1026:1: error: directive in macro's argument list
+mm/page_alloc.c:1028:1: error: directive in macro's argument list
+mm/page_alloc.c:7564:1: error: directive in macro's argument list
+mm/page_alloc.c:7566:1: error: directive in macro's argument list
+mm/page_alloc.c:7574:1: error: directive in macro's argument list
+mm/page_alloc.c:7576:1: error: directive in macro's argument list
+  CC      mm/page_alloc.o
+  CHECK   mm/shuffle.c
+  CC      mm/shuffle.o
+  CHECK   mm/init-mm.c
+  CC      mm/init-mm.o
+  CHECK   mm/memblock.c
+  CC      mm/memblock.o
+  CHECK   mm/madvise.c
+mm/madvise.c:375:28: warning: context imbalance in 'madvise_cold_or_pageout_pte_range' - unexpected unlock
+  CC      mm/madvise.o
+  CHECK   mm/page_io.c
+  CC      mm/page_io.o
+  CHECK   mm/swap_state.c
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'total_swapcache_pages' - unexpected unlock
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'lookup_swap_cache' - unexpected unlock
+./include/linux/rcupdate.h:669:9: warning: context imbalance in '__read_swap_cache_async' - unexpected unlock
+  CC      mm/swap_state.o
+  CHECK   mm/swapfile.c
+mm/swapfile.c:476:35: warning: context imbalance in 'swap_do_scheduled_discard' - different lock contexts for basic block
+mm/swapfile.c:647:23: warning: context imbalance in 'scan_swap_map_try_ssd_cluster' - different lock contexts for basic block
+mm/swapfile.c:891:20: warning: context imbalance in 'scan_swap_map_slots' - unexpected unlock
+mm/swapfile.c:957:23: warning: context imbalance in 'swap_alloc_cluster' - different lock contexts for basic block
+mm/swapfile.c:973:23: warning: context imbalance in 'swap_free_cluster' - different lock contexts for basic block
+mm/swapfile.c:1151:32: warning: context imbalance in 'swap_info_get' - wrong count at exit
+mm/swapfile.c:1170:36: warning: context imbalance in 'swap_info_get_cont' - unexpected unlock
+mm/swapfile.c:1249:25: warning: context imbalance in 'get_swap_device' - different lock contexts for basic block
+mm/swapfile.c:361:40: warning: context imbalance in '__swap_entry_free' - different lock contexts for basic block
+mm/swapfile.c:1303:23: warning: context imbalance in 'swap_entry_free' - different lock contexts for basic block
+mm/swapfile.c:1360:34: warning: context imbalance in 'put_swap_page' - different lock contexts for basic block
+mm/swapfile.c:1384:23: warning: context imbalance in 'split_swap_cluster' - different lock contexts for basic block
+mm/swapfile.c:1421:28: warning: context imbalance in 'swapcache_free_entries' - unexpected unlock
+mm/swapfile.c:361:40: warning: context imbalance in 'page_swapcount' - different lock contexts for basic block
+./include/linux/rcupdate.h:669:9: warning: context imbalance in '__swap_count' - unexpected unlock
+mm/swapfile.c:361:40: warning: context imbalance in 'swap_swapcount' - different lock contexts for basic block
+./include/linux/rcupdate.h:669:9: warning: context imbalance in '__swp_swapcount' - unexpected unlock
+mm/swapfile.c:361:40: warning: context imbalance in 'swp_swapcount' - different lock contexts for basic block
+mm/swapfile.c:1550:31: warning: context imbalance in 'swap_page_trans_huge_swapped' - different lock contexts for basic block
+./include/linux/page-flags.h:550:1: warning: context imbalance in 'page_trans_huge_map_swapcount' - different lock contexts for basic block
+mm/swapfile.c:1679:44: warning: context imbalance in 'reuse_swap_page' - unexpected unlock
+./include/linux/rcupdate.h:669:9: warning: context imbalance in '__swap_duplicate' - unexpected unlock
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'add_swap_count_continuation' - unexpected unlock
+  CC      mm/swapfile.o
+  CHECK   mm/swap_slots.c
+  CC      mm/swap_slots.o
+  CHECK   mm/frontswap.c
+  CC      mm/frontswap.o
+  CHECK   mm/zswap.c
+  CC      mm/zswap.o
+  CHECK   mm/dmapool.c
+  CC      mm/dmapool.o
+  CHECK   mm/hugetlb.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+mm/hugetlb.c:1786:20: warning: context imbalance in 'gather_surplus_pages' - unexpected unlock
+./include/linux/kasan-checks.h:38:20: warning: context imbalance in 'hugetlb_cow' - unexpected unlock
+mm/hugetlb.c:4410:25: warning: context imbalance in 'follow_hugetlb_page' - different lock contexts for basic block
+  CC      mm/hugetlb.o
+  CHECK   mm/mempolicy.c
+mm/mempolicy.c:455:28: warning: context imbalance in 'queue_pages_pmd' - unexpected unlock
+  CC      mm/mempolicy.o
+  CHECK   mm/sparse.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC      mm/sparse.o
+  CHECK   mm/sparse-vmemmap.c
+  CC      mm/sparse-vmemmap.o
+  CHECK   mm/mmu_notifier.c
+  CC      mm/mmu_notifier.o
+  CHECK   mm/ksm.c
+./include/linux/rmap.h:220:28: warning: context imbalance in 'write_protect_page' - unexpected unlock
+  CC      mm/ksm.o
+  CHECK   mm/page_poison.c
+  CC      mm/page_poison.o
+  CHECK   mm/slub.c
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2982:21:    got void ***
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2982:21:    got unsigned long *
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2982:21:    got void ***
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2982:21:    got unsigned long *
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2982:21:    got void ***
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2982:21:    got unsigned long *
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2982:21:    got void ***
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2982:21:    got unsigned long *
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2982:21:    got void ***
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2982:21:    got unsigned long *
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2982:21:    got void ***
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2982:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2982:21:    got void ***
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2982:21:    got unsigned long *
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2982:21:    got void ***
+mm/slub.c:2982:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2982:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2982:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected void **[noderef] <asn:3> *__p1
+mm/slub.c:2741:21:    got void ***
+mm/slub.c:2741:21: warning: incorrect type in initializer (different address spaces)
+mm/slub.c:2741:21:    expected unsigned long [noderef] <asn:3> *__p2
+mm/slub.c:2741:21:    got unsigned long *
+mm/slub.c:2160:28: warning: context imbalance in 'deactivate_slab' - unexpected unlock
+mm/slub.c:2199:44: warning: context imbalance in 'unfreeze_partials' - unexpected unlock
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+mm/slub.c:2741:21: warning: dereference of noderef expression
+./include/linux/spinlock.h:393:9: warning: context imbalance in '__slab_free' - unexpected unlock
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: dereference of noderef expression
+mm/slub.c:2982:21: warning: too many warnings
+  CC      mm/slub.o
+  CHECK   mm/kasan/common.c
+  CC      mm/kasan/common.o
+  CHECK   mm/kasan/init.c
+  CC      mm/kasan/init.o
+  CHECK   mm/kasan/report.c
+mm/kasan/report.c:474:6: warning: symbol '__kasan_report' was not declared. Should it be static?
+mm/kasan/report.c:80:13: warning: context imbalance in 'start_report' - wrong count at exit
+mm/kasan/report.c:90:13: warning: context imbalance in 'end_report' - unexpected unlock
+  CC      mm/kasan/report.o
+  CHECK   mm/kasan/generic.c
+  CC      mm/kasan/generic.o
+  CHECK   mm/kasan/generic_report.c
+mm/kasan/generic_report.c:129:1: warning: symbol '__asan_report_load1_noabort' was not declared. Should it be static?
+mm/kasan/generic_report.c:130:1: warning: symbol '__asan_report_load2_noabort' was not declared. Should it be static?
+mm/kasan/generic_report.c:131:1: warning: symbol '__asan_report_load4_noabort' was not declared. Should it be static?
+mm/kasan/generic_report.c:132:1: warning: symbol '__asan_report_load8_noabort' was not declared. Should it be static?
+mm/kasan/generic_report.c:133:1: warning: symbol '__asan_report_load16_noabort' was not declared. Should it be static?
+mm/kasan/generic_report.c:134:1: warning: symbol '__asan_report_store1_noabort' was not declared. Should it be static?
+mm/kasan/generic_report.c:135:1: warning: symbol '__asan_report_store2_noabort' was not declared. Should it be static?
+mm/kasan/generic_report.c:136:1: warning: symbol '__asan_report_store4_noabort' was not declared. Should it be static?
+mm/kasan/generic_report.c:137:1: warning: symbol '__asan_report_store8_noabort' was not declared. Should it be static?
+mm/kasan/generic_report.c:138:1: warning: symbol '__asan_report_store16_noabort' was not declared. Should it be static?
+mm/kasan/generic_report.c:140:6: warning: symbol '__asan_report_load_n_noabort' was not declared. Should it be static?
+mm/kasan/generic_report.c:146:6: warning: symbol '__asan_report_store_n_noabort' was not declared. Should it be static?
+  CC      mm/kasan/generic_report.o
+  CHECK   mm/kasan/quarantine.c
+  CC      mm/kasan/quarantine.o
+  AR      mm/kasan/built-in.a
+  CHECK   mm/failslab.c
+  CC      mm/failslab.o
+  CHECK   mm/memory_hotplug.c
+  CC      mm/memory_hotplug.o
+  CHECK   mm/memtest.c
+  CC      mm/memtest.o
+  CHECK   mm/migrate.c
+mm/migrate.c:811:9: warning: context imbalance in '__buffer_migrate_page' - different lock contexts for basic block
+  CC      mm/migrate.o
+  CHECK   mm/huge_memory.c
+mm/huge_memory.c:1758:20: warning: context imbalance in 'madvise_free_huge_pmd' - unexpected unlock
+mm/huge_memory.c:1795:28: warning: context imbalance in 'zap_huge_pmd' - unexpected unlock
+mm/huge_memory.c:1911:28: warning: context imbalance in 'move_huge_pmd' - unexpected unlock
+mm/huge_memory.c:2001:20: warning: context imbalance in 'change_huge_pmd' - unexpected unlock
+mm/huge_memory.c:2011:12: warning: context imbalance in '__pmd_trans_huge_lock' - wrong count at exit
+mm/huge_memory.c:2028:12: warning: context imbalance in '__pud_trans_huge_lock' - wrong count at exit
+mm/huge_memory.c:2057:28: warning: context imbalance in 'zap_huge_pud' - unexpected unlock
+mm/huge_memory.c:2557:31: warning: context imbalance in '__split_huge_page' - unexpected unlock
+./include/linux/spinlock.h:393:9: warning: context imbalance in 'split_huge_page_to_list' - different lock contexts for basic block
+  CC      mm/huge_memory.o
+  CHECK   mm/khugepaged.c
+  CC      mm/khugepaged.o
+  CHECK   mm/page_counter.c
+  CC      mm/page_counter.o
+  CHECK   mm/memcontrol.c
+mm/memcontrol.c:3983:21: error: incompatible types in comparison expression (different address spaces):
+mm/memcontrol.c:3983:21:    struct mem_cgroup_threshold_ary [noderef] <asn:4> *
+mm/memcontrol.c:3983:21:    struct mem_cgroup_threshold_ary *
+mm/memcontrol.c:3985:21: error: incompatible types in comparison expression (different address spaces):
+mm/memcontrol.c:3985:21:    struct mem_cgroup_threshold_ary [noderef] <asn:4> *
+mm/memcontrol.c:3985:21:    struct mem_cgroup_threshold_ary *
+mm/memcontrol.c:4142:9: error: incompatible types in comparison expression (different address spaces):
+mm/memcontrol.c:4142:9:    struct mem_cgroup_threshold_ary [noderef] <asn:4> *
+mm/memcontrol.c:4142:9:    struct mem_cgroup_threshold_ary *
+mm/memcontrol.c:4230:9: error: incompatible types in comparison expression (different address spaces):
+mm/memcontrol.c:4230:9:    struct mem_cgroup_threshold_ary [noderef] <asn:4> *
+mm/memcontrol.c:4230:9:    struct mem_cgroup_threshold_ary *
+mm/memcontrol.c:5808:23: error: incompatible types in comparison expression (different address spaces):
+mm/memcontrol.c:5808:23:    struct task_struct [noderef] <asn:4> *
+mm/memcontrol.c:5808:23:    struct task_struct *
+mm/memcontrol.c:2073:19: warning: context imbalance in 'lock_page_memcg' - wrong count at exit
+mm/memcontrol.c:2128:17: warning: context imbalance in '__unlock_page_memcg' - unexpected unlock
+mm/memcontrol.c:2695:9: warning: context imbalance in 'lock_page_lru' - wrong count at exit
+mm/memcontrol.c:2718:24: warning: context imbalance in 'unlock_page_lru' - unexpected unlock
+mm/memcontrol.c:5656:28: warning: context imbalance in 'mem_cgroup_count_precharge_pte_range' - unexpected unlock
+mm/memcontrol.c:5853:36: warning: context imbalance in 'mem_cgroup_move_charge_pte_range' - unexpected unlock
+  CC      mm/memcontrol.o
+  CHECK   mm/vmpressure.c
+  CC      mm/vmpressure.o
+  CHECK   mm/swap_cgroup.c
+  CC      mm/swap_cgroup.o
+  CHECK   mm/hugetlb_cgroup.c
+  CC      mm/hugetlb_cgroup.o
+  CHECK   mm/gup_benchmark.c
+  CC      mm/gup_benchmark.o
+  CHECK   mm/memory-failure.c
+  CC      mm/memory-failure.o
+  CHECK   mm/kmemleak.c
+mm/kmemleak.c:1614:13: warning: context imbalance in 'kmemleak_seq_start' - different lock contexts for basic block
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'kmemleak_seq_stop' - unexpected unlock
+  CC      mm/kmemleak.o
+  CHECK   mm/rodata_test.c
+mm/rodata_test.c:15:6: warning: symbol 'rodata_test' was not declared. Should it be static?
+  CC      mm/rodata_test.o
+  CHECK   mm/page_owner.c
+./include/linux/gfp.h:318:27: warning: restricted gfp_t degrades to integer
+./include/linux/gfp.h:318:27: warning: restricted gfp_t degrades to integer
+./include/linux/gfp.h:318:27: warning: restricted gfp_t degrades to integer
+  CC      mm/page_owner.o
+  CHECK   mm/cleancache.c
+  CC      mm/cleancache.o
+  CHECK   mm/page_isolation.c
+  CC      mm/page_isolation.o
+  CHECK   mm/zpool.c
+  CC      mm/zpool.o
+  CHECK   mm/early_ioremap.c
+mm/early_ioremap.c:34:24: warning: symbol 'early_memremap_pgprot_adjust' was not declared. Should it be static?
+  CC      mm/early_ioremap.o
+  CHECK   mm/cma.c
+  CC      mm/cma.o
+  CHECK   mm/balloon_compaction.c
+  CC      mm/balloon_compaction.o
+  CHECK   mm/page_ext.c
+  CC      mm/page_ext.o
+  CHECK   mm/cma_debug.c
+  CC      mm/cma_debug.o
+  CHECK   mm/userfaultfd.c
+  CC      mm/userfaultfd.o
+  CHECK   mm/page_idle.c
+  CC      mm/page_idle.o
+  CHECK   mm/frame_vector.c
+  CC      mm/frame_vector.o
+  CHECK   mm/debug_page_ref.c
+  CC      mm/debug_page_ref.o
+  CHECK   mm/usercopy.c
+  CC      mm/usercopy.o
+  CHECK   mm/percpu-stats.c
+  CC      mm/percpu-stats.o
+  CHECK   mm/memremap.c
+  CC      mm/memremap.o
+  CHECK   mm/hmm.c
+  CC      mm/hmm.o
+  CHECK   mm/memfd.c
+  CC      mm/memfd.o
+  AR      mm/built-in.a
+  CHECK   mm/hwpoison-inject.c
+  CC [M]  mm/hwpoison-inject.o
+  CHECK   mm/kmemleak-test.c
+  CC [M]  mm/kmemleak-test.o
+  CHECK   mm/zbud.c
+  CC [M]  mm/zbud.o
+  CHECK   mm/zsmalloc.c
+mm/zsmalloc.c:894:13: warning: context imbalance in 'pin_tag' - wrong count at exit
+./include/linux/kasan-checks.h:38:20: warning: context imbalance in 'unpin_tag' - unexpected unlock
+mm/zsmalloc.c:1677:9: warning: context imbalance in 'find_alloced_obj' - wrong count at exit
+mm/zsmalloc.c:1836:13: warning: context imbalance in 'migrate_read_lock' - wrong count at exit
+mm/zsmalloc.c:1841:13: warning: context imbalance in 'migrate_read_unlock' - unexpected unlock
+mm/zsmalloc.c:1846:13: warning: context imbalance in 'migrate_write_lock' - wrong count at exit
+mm/zsmalloc.c:1851:13: warning: context imbalance in 'migrate_write_unlock' - unexpected unlock
+mm/zsmalloc.c:2018:9: warning: context imbalance in 'zs_page_migrate' - different lock contexts for basic block
+  CC [M]  mm/zsmalloc.o
+  CHECK   mm/z3fold.c
+mm/z3fold.c:542:47: warning: incorrect type in initializer (different address spaces)
+mm/z3fold.c:542:47:    expected void const [noderef] <asn:3> *__vpp_verify
+mm/z3fold.c:542:47:    got struct list_head *
+mm/z3fold.c:781:25: warning: incorrect type in assignment (different address spaces)
+mm/z3fold.c:781:25:    expected struct list_head *unbuddied
+mm/z3fold.c:781:25:    got void [noderef] <asn:3> *
+mm/z3fold.c:786:33: warning: incorrect type in initializer (different address spaces)
+mm/z3fold.c:786:33:    expected void const [noderef] <asn:3> *__vpp_verify
+mm/z3fold.c:786:33:    got struct list_head *
+mm/z3fold.c:811:25: warning: incorrect type in argument 1 (different address spaces)
+mm/z3fold.c:811:25:    expected void [noderef] <asn:3> *__pdata
+mm/z3fold.c:811:25:    got struct list_head *unbuddied
+mm/z3fold.c:665:21: warning: incorrect type in initializer (different address spaces)
+mm/z3fold.c:665:21:    expected void const [noderef] <asn:3> *__vpp_verify
+mm/z3fold.c:665:21:    got struct list_head *
+mm/z3fold.c:720:37: warning: incorrect type in initializer (different address spaces)
+mm/z3fold.c:720:37:    expected void const [noderef] <asn:3> *__vpp_verify
+mm/z3fold.c:720:37:    got struct list_head *
+mm/z3fold.c:542:47: warning: incorrect type in initializer (different address spaces)
+mm/z3fold.c:542:47:    expected void const [noderef] <asn:3> *__vpp_verify
+mm/z3fold.c:542:47:    got struct list_head *
+mm/z3fold.c:454:35: warning: context imbalance in '__release_z3fold_page' - unexpected unlock
+mm/z3fold.c:473:9: warning: context imbalance in 'release_z3fold_page_locked' - wrong count at exit
+mm/z3fold.c:486:9: warning: context imbalance in 'release_z3fold_page_locked_list' - wrong count at exit
+mm/z3fold.c:621:13: warning: context imbalance in 'do_compact_page' - different lock contexts for basic block
+mm/z3fold.c:981:35: warning: context imbalance in 'z3fold_alloc' - unexpected unlock
+mm/z3fold.c:996:13: warning: context imbalance in 'z3fold_free' - different lock contexts for basic block
+mm/z3fold.c:1112:12: warning: context imbalance in 'z3fold_reclaim_page' - different lock contexts for basic block
+mm/z3fold.c:1437:13: warning: context imbalance in 'z3fold_page_putback' - wrong count at exit
+  CC [M]  mm/z3fold.o
+  CHECK   fs/open.c
+fs/open.c:757:13: warning: restricted fmode_t degrades to integer
+fs/open.c:975:18: warning: restricted fmode_t degrades to integer
+  CC      fs/open.o
+  CHECK   fs/read_write.c
+  CC      fs/read_write.o
+  CHECK   fs/file_table.c
+  CC      fs/file_table.o
+  CHECK   fs/super.c
+  CC      fs/super.o
+  CHECK   fs/char_dev.c
+  CC      fs/char_dev.o
+  CHECK   fs/stat.c
+  CC      fs/stat.o
+  CHECK   fs/exec.c
+fs/exec.c:410:39: warning: incorrect type in return expression (different address spaces)
+fs/exec.c:410:39:    expected char const [noderef] <asn:1> *
+fs/exec.c:410:39:    got void *
+fs/exec.c:417:31: warning: incorrect type in return expression (different address spaces)
+fs/exec.c:417:31:    expected char const [noderef] <asn:1> *
+fs/exec.c:417:31:    got void *
+fs/exec.c:1175:56: warning: incorrect type in argument 2 (different address spaces)
+fs/exec.c:1175:56:    expected struct task_struct *parent
+fs/exec.c:1175:56:    got struct task_struct [noderef] <asn:4> *parent
+fs/exec.c:1210:17: error: incompatible types in comparison expression (different address spaces):
+fs/exec.c:1210:17:    struct sighand_struct [noderef] <asn:4> *
+fs/exec.c:1210:17:    struct sighand_struct *
+fs/exec.c:1699:70: warning: incorrect type in argument 1 (different address spaces)
+fs/exec.c:1699:70:    expected struct task_struct *tsk
+fs/exec.c:1699:70:    got struct task_struct [noderef] <asn:4> *parent
+fs/exec.c:1873:52: warning: incorrect type in initializer (different address spaces)
+fs/exec.c:1873:52:    expected char const [noderef] <asn:1> *const [noderef] <asn:1> *native
+fs/exec.c:1873:52:    got void *__argv
+fs/exec.c:1874:52: warning: incorrect type in initializer (different address spaces)
+fs/exec.c:1874:52:    expected char const [noderef] <asn:1> *const [noderef] <asn:1> *native
+fs/exec.c:1874:52:    got void *__envp
+  CC      fs/exec.o
+  CHECK   fs/pipe.c
+  CC      fs/pipe.o
+  CHECK   fs/namei.c
+fs/namei.c:1928:14: error: symbol 'full_name_hash' redeclared with different type (originally declared at ./include/linux/stringhash.h:66) - different modifiers
+fs/namei.c:1949:5: error: symbol 'hashlen_string' redeclared with different type (originally declared at ./include/linux/stringhash.h:77) - different modifiers
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'terminate_walk' - unexpected unlock
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'unlazy_walk' - unexpected unlock
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'unlazy_child' - unexpected unlock
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'pick_link' - unexpected unlock
+fs/namei.c:2162:19: warning: context imbalance in 'path_init' - wrong count at exit
+  CC      fs/namei.o
+  CHECK   fs/fcntl.c
+fs/fcntl.c:280:22: warning: incorrect type in initializer (different address spaces)
+fs/fcntl.c:280:22:    expected unsigned long long [usertype] *argp
+fs/fcntl.c:280:22:    got unsigned long long [noderef] [usertype] <asn:1> *
+fs/fcntl.c:287:34: warning: incorrect type in argument 1 (different address spaces)
+fs/fcntl.c:287:34:    expected void [noderef] <asn:1> *to
+fs/fcntl.c:287:34:    got unsigned long long [usertype] *argp
+fs/fcntl.c:291:40: warning: incorrect type in argument 2 (different address spaces)
+fs/fcntl.c:291:40:    expected void const [noderef] <asn:1> *from
+fs/fcntl.c:291:40:    got unsigned long long [usertype] *argp
+fs/fcntl.c:303:34: warning: incorrect type in argument 1 (different address spaces)
+fs/fcntl.c:303:34:    expected void [noderef] <asn:1> *to
+fs/fcntl.c:303:34:    got unsigned long long [usertype] *argp
+fs/fcntl.c:307:40: warning: incorrect type in argument 2 (different address spaces)
+fs/fcntl.c:307:40:    expected void const [noderef] <asn:1> *from
+fs/fcntl.c:307:40:    got unsigned long long [usertype] *argp
+fs/fcntl.c:936:9: error: incompatible types in comparison expression (different address spaces):
+fs/fcntl.c:936:9:    struct fasync_struct [noderef] <asn:4> *
+fs/fcntl.c:936:9:    struct fasync_struct *
+fs/fcntl.c:1010:22: error: incompatible types in comparison expression (different address spaces):
+fs/fcntl.c:1010:22:    struct fasync_struct [noderef] <asn:4> *
+fs/fcntl.c:1010:22:    struct fasync_struct *
+fs/fcntl.c:1021:33: error: incompatible types in comparison expression (different address spaces):
+fs/fcntl.c:1021:33:    struct fasync_struct [noderef] <asn:4> *
+fs/fcntl.c:1021:33:    struct fasync_struct *
+  CC      fs/fcntl.o
+  CHECK   fs/ioctl.c
+  CC      fs/ioctl.o
+  CHECK   fs/readdir.c
+  CC      fs/readdir.o
+  CHECK   fs/select.c
+  CC      fs/select.o
+  CHECK   fs/dcache.c
+./include/linux/rculist_bl.h:24:33: error: incompatible types in comparison expression (different address spaces):
+./include/linux/rculist_bl.h:24:33:    struct hlist_bl_node [noderef] <asn:4> *
+./include/linux/rculist_bl.h:24:33:    struct hlist_bl_node *
+./include/linux/rculist_bl.h:24:33: error: incompatible types in comparison expression (different address spaces):
+./include/linux/rculist_bl.h:24:33:    struct hlist_bl_node [noderef] <asn:4> *
+./include/linux/rculist_bl.h:24:33:    struct hlist_bl_node *
+./include/linux/rculist_bl.h:17:9: error: incompatible types in comparison expression (different address spaces):
+./include/linux/rculist_bl.h:17:9:    struct hlist_bl_node [noderef] <asn:4> *
+./include/linux/rculist_bl.h:17:9:    struct hlist_bl_node *
+./include/linux/rculist_bl.h:17:9: error: incompatible types in comparison expression (different address spaces):
+./include/linux/rculist_bl.h:17:9:    struct hlist_bl_node [noderef] <asn:4> *
+./include/linux/rculist_bl.h:17:9:    struct hlist_bl_node *
+fs/dcache.c:577:28: warning: context imbalance in '__dentry_kill' - unexpected unlock
+fs/dcache.c:622:9: warning: context imbalance in '__lock_parent' - wrong count at exit
+fs/dcache.c:706:20: warning: context imbalance in 'dentry_kill' - different lock contexts for basic block
+fs/dcache.c:859:17: warning: context imbalance in 'dput' - unexpected unlock
+fs/dcache.c:888:20: warning: context imbalance in 'dput_to_list' - unexpected unlock
+fs/dcache.c:1025:18: warning: context imbalance in 'd_prune_aliases' - different lock contexts for basic block
+fs/dcache.c:1055:13: warning: context imbalance in 'shrink_lock_dentry' - different lock contexts for basic block
+./include/linux/compiler.h:199:9: warning: context imbalance in 'shrink_dentry_list' - different lock contexts for basic block
+fs/dcache.c:1205:24: warning: context imbalance in 'dentry_lru_isolate_shrink' - different lock contexts for basic block
+fs/dcache.c:1267:13: warning: context imbalance in 'd_walk' - different lock contexts for basic block
+fs/dcache.c:1501:24: warning: context imbalance in 'select_collect2' - different lock contexts for basic block
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'shrink_dcache_parent' - unexpected unlock
+fs/dcache.c:2674:6: warning: context imbalance in 'd_add' - different lock contexts for basic block
+fs/dcache.c:2878:20: warning: context imbalance in '__d_move' - unexpected unlock
+fs/dcache.c:3044:16: warning: context imbalance in 'd_splice_alias' - different lock contexts for basic block
+  CC      fs/dcache.o
+  CHECK   fs/inode.c
+fs/inode.c:757:17: warning: context imbalance in 'inode_lru_isolate' - unexpected unlock
+fs/inode.c:813:9: warning: context imbalance in 'find_inode' - different lock contexts for basic block
+fs/inode.c:844:9: warning: context imbalance in 'find_inode_fast' - different lock contexts for basic block
+fs/inode.c:1450:5: warning: context imbalance in 'insert_inode_locked' - wrong count at exit
+fs/inode.c:1561:20: warning: context imbalance in 'iput_final' - unexpected unlock
+fs/inode.c:1575:6: warning: context imbalance in 'iput' - wrong count at exit
+fs/inode.c:1946:13: warning: context imbalance in '__wait_on_freeing_inode' - unexpected unlock
+  CC      fs/inode.o
+  CHECK   fs/attr.c
+  CC      fs/attr.o
+  CHECK   fs/bad_inode.c
+  CC      fs/bad_inode.o
+  CHECK   fs/file.c
+fs/file.c:23:14: warning: symbol 'sysctl_nr_open_min' was not declared. Should it be static?
+fs/file.c:26:14: warning: symbol 'sysctl_nr_open_max' was not declared. Should it be static?
+fs/file.c:335:17: warning: incorrect type in assignment (different address spaces)
+fs/file.c:335:17:    expected struct file **old_fds
+fs/file.c:335:17:    got struct file [noderef] <asn:4> **fd
+fs/file.c:336:17: warning: incorrect type in assignment (different address spaces)
+fs/file.c:336:17:    expected struct file **new_fds
+fs/file.c:336:17:    got struct file [noderef] <asn:4> **fd
+fs/file.c:351:17: error: incompatible types in comparison expression (different address spaces):
+fs/file.c:351:17:    struct file [noderef] <asn:4> *
+fs/file.c:351:17:    struct file *
+fs/file.c:386:54: warning: incorrect type in initializer (different address spaces)
+fs/file.c:386:54:    expected struct file *file
+fs/file.c:386:54:    got struct file [noderef] <asn:4> *[assigned] __ret
+fs/file.c:451:28: warning: incorrect type in initializer (different address spaces)
+fs/file.c:451:28:    expected struct fdtable [noderef] <asn:4> *fdt
+fs/file.c:451:28:    got struct fdtable *
+fs/file.c:449:21: warning: symbol 'init_files' was not declared. Should it be static?
+fs/file.c:630:14: warning: incorrect type in assignment (different address spaces)
+fs/file.c:630:14:    expected struct file *file
+fs/file.c:630:14:    got struct file [noderef] <asn:4> *
+fs/file.c:657:14: warning: incorrect type in assignment (different address spaces)
+fs/file.c:657:14:    expected struct file *file
+fs/file.c:657:14:    got struct file [noderef] <asn:4> *
+fs/file.c:694:30: warning: incorrect type in assignment (different address spaces)
+fs/file.c:694:30:    expected struct file *file
+fs/file.c:694:30:    got struct file [noderef] <asn:4> *
+fs/file.c:865:16: warning: incorrect type in assignment (different address spaces)
+fs/file.c:865:16:    expected struct file *tofree
+fs/file.c:865:16:    got struct file [noderef] <asn:4> *
+  CC      fs/file.o
+  CHECK   fs/filesystems.c
+  CC      fs/filesystems.o
+  CHECK   fs/namespace.c
+fs/namespace.c:1731:22: warning: symbol 'to_mnt_ns' was not declared. Should it be static?
+fs/namespace.c:2392:35: warning: incorrect type in argument 2 (different address spaces)
+fs/namespace.c:2392:35:    expected char const [noderef] <asn:1> *name
+fs/namespace.c:2392:35:    got char const *filename
+fs/namespace.c:3540:38: warning: incorrect type in argument 2 (different address spaces)
+fs/namespace.c:3540:38:    expected char const [noderef] <asn:1> *name
+fs/namespace.c:3540:38:    got char const *from_pathname
+fs/namespace.c:3549:36: warning: incorrect type in argument 2 (different address spaces)
+fs/namespace.c:3549:36:    expected char const [noderef] <asn:1> *name
+fs/namespace.c:3549:36:    got char const *to_pathname
+  CC      fs/namespace.o
+  CHECK   fs/seq_file.c
+fs/seq_file.c:1048:24: error: incompatible types in comparison expression (different address spaces):
+fs/seq_file.c:1048:24:    struct hlist_node [noderef] <asn:4> *
+fs/seq_file.c:1048:24:    struct hlist_node *
+fs/seq_file.c:1050:24: error: incompatible types in comparison expression (different address spaces):
+fs/seq_file.c:1050:24:    struct hlist_node [noderef] <asn:4> *
+fs/seq_file.c:1050:24:    struct hlist_node *
+  CC      fs/seq_file.o
+  CHECK   fs/xattr.c
+  CC      fs/xattr.o
+  CHECK   fs/libfs.c
+  CC      fs/libfs.o
+  CHECK   fs/fs-writeback.c
+./include/linux/backing-dev.h:158:39: warning: context imbalance in 'wbc_attach_and_unlock_inode' - unexpected unlock
+./include/linux/rcupdate.h:667:9: warning: context imbalance in 'inode_congested' - different lock contexts for basic block
+fs/fs-writeback.c:1580:20: warning: context imbalance in 'writeback_single_inode' - different lock contexts for basic block
+fs/fs-writeback.c:1763:9: warning: context imbalance in 'writeback_sb_inodes' - different lock contexts for basic block
+fs/fs-writeback.c:2197:9: warning: context imbalance in 'block_dump___mark_inode_dirty' - different lock contexts for basic block
+  CC      fs/fs-writeback.o
+  CHECK   fs/pnode.c
+  CC      fs/pnode.o
+  CHECK   fs/splice.c
+  CC      fs/splice.o
+  CHECK   fs/sync.c
+  CC      fs/sync.o
+  CHECK   fs/utimes.c
+  CC      fs/utimes.o
+  CHECK   fs/d_path.c
+fs/d_path.c:311:6: warning: symbol 'simple_dname' was not declared. Should it be static?
+fs/d_path.c:155:9: warning: context imbalance in 'prepend_path' - wrong count at exit
+./include/linux/err.h:24:20: warning: context imbalance in '__dentry_path' - different lock contexts for basic block
+  CC      fs/d_path.o
+  CHECK   fs/stack.c
+  CC      fs/stack.o
+  CHECK   fs/fs_struct.c
+fs/fs_struct.c:163:18: warning: symbol 'init_fs' was not declared. Should it be static?
+  CC      fs/fs_struct.o
+  CHECK   fs/statfs.c
+  CC      fs/statfs.o
+  CHECK   fs/fs_pin.c
+./include/linux/rcupdate.h:669:9: warning: context imbalance in 'pin_kill' - unexpected unlock
+./arch/x86/include/asm/preempt.h:79:9: warning: context imbalance in 'mnt_pin_kill' - different lock contexts for basic block
+./arch/x86/include/asm/preempt.h:79:9: warning: context imbalance in 'group_pin_kill' - different lock contexts for basic block
+  CC      fs/fs_pin.o
+  CHECK   fs/nsfs.c
+fs/nsfs.c:41:32: warning: symbol 'ns_dentry_operations' was not declared. Should it be static?
+fs/nsfs.c:145:5: warning: symbol 'open_related_ns' was not declared. Should it be static?
+  CC      fs/nsfs.o
+  CHECK   fs/fs_types.c
+  CC      fs/fs_types.o
+  CHECK   fs/fs_context.c
+  CC      fs/fs_context.o
+  CHECK   fs/fs_parser.c
+  CC      fs/fs_parser.o
+  CHECK   fs/fsopen.c
+  CC      fs/fsopen.o
+  CHECK   fs/buffer.c
+fs/buffer.c:1930:5: warning: symbol '__block_write_begin_int' was not declared. Should it be static?
+fs/buffer.c:2994:6: warning: symbol 'guard_bio_eod' was not declared. Should it be static?
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC      fs/buffer.o
+  CHECK   fs/block_dev.c
+  CC      fs/block_dev.o
+  CHECK   fs/direct-io.c
+fs/direct-io.c:612:5: warning: symbol 'sb_init_dio_done_wq' was not declared. Should it be static?
+fs/direct-io.c:1177:36: warning: Using plain integer as NULL pointer
+  CC      fs/direct-io.o
+  CHECK   fs/mpage.c
+  CC      fs/mpage.o
+  CHECK   fs/proc_namespace.c
+  CC      fs/proc_namespace.o
+  CHECK   fs/9p/vfs_super.c
+  CC [M]  fs/9p/vfs_super.o
+  CHECK   fs/9p/vfs_inode.c
+  CC [M]  fs/9p/vfs_inode.o
+  CHECK   fs/9p/vfs_inode_dotl.c
+  CC [M]  fs/9p/vfs_inode_dotl.o
+  CHECK   fs/9p/vfs_addr.c
+  CC [M]  fs/9p/vfs_addr.o
+  CHECK   fs/9p/vfs_file.c
+  CC [M]  fs/9p/vfs_file.o
+  CHECK   fs/9p/vfs_dir.c
+  CC [M]  fs/9p/vfs_dir.o
+  CHECK   fs/9p/vfs_dentry.c
+  CC [M]  fs/9p/vfs_dentry.o
+  CHECK   fs/9p/v9fs.c
+  CC [M]  fs/9p/v9fs.o
+  CHECK   fs/9p/fid.c
+  CC [M]  fs/9p/fid.o
+  CHECK   fs/9p/xattr.c
+  CC [M]  fs/9p/xattr.o
+  CHECK   fs/9p/cache.c
+  CC [M]  fs/9p/cache.o
+  CHECK   fs/9p/acl.c
+  CC [M]  fs/9p/acl.o
+  LD [M]  fs/9p/9p.o
+  CHECK   fs/adfs/dir.c
+  CC [M]  fs/adfs/dir.o
+  CHECK   fs/adfs/dir_f.c
+  CC [M]  fs/adfs/dir_f.o
+  CHECK   fs/adfs/dir_fplus.c
+  CC [M]  fs/adfs/dir_fplus.o
+  CHECK   fs/adfs/file.c
+  CC [M]  fs/adfs/file.o
+  CHECK   fs/adfs/inode.c
+  CC [M]  fs/adfs/inode.o
+  CHECK   fs/adfs/map.c
+  CC [M]  fs/adfs/map.o
+  CHECK   fs/adfs/super.c
+  CC [M]  fs/adfs/super.o
+  LD [M]  fs/adfs/adfs.o
+  CHECK   fs/affs/super.c
+  CC [M]  fs/affs/super.o
+  CHECK   fs/affs/namei.c
+  CC [M]  fs/affs/namei.o
+  CHECK   fs/affs/inode.c
+  CC [M]  fs/affs/inode.o
+  CHECK   fs/affs/file.c
+  CC [M]  fs/affs/file.o
+  CHECK   fs/affs/dir.c
+  CC [M]  fs/affs/dir.o
+  CHECK   fs/affs/amigaffs.c
+  CC [M]  fs/affs/amigaffs.o
+  CHECK   fs/affs/bitmap.c
+  CC [M]  fs/affs/bitmap.o
+  CHECK   fs/affs/symlink.c
+  CC [M]  fs/affs/symlink.o
+  LD [M]  fs/affs/affs.o
+  CHECK   fs/afs/cache.c
+  CC [M]  fs/afs/cache.o
+  CHECK   fs/afs/addr_list.c
+  CC [M]  fs/afs/addr_list.o
+  CHECK   fs/afs/callback.c
+  CC [M]  fs/afs/callback.o
+  CHECK   fs/afs/cell.c
+./include/linux/rbtree.h:84:9: error: incompatible types in comparison expression (different address spaces):
+./include/linux/rbtree.h:84:9:    struct rb_node [noderef] <asn:4> *
+./include/linux/rbtree.h:84:9:    struct rb_node *
+fs/afs/cell.c:604:9: error: incompatible types in comparison expression (different address spaces):
+fs/afs/cell.c:604:9:    struct hlist_node [noderef] <asn:4> *
+fs/afs/cell.c:604:9:    struct hlist_node *
+fs/afs/cell.c:68:17: warning: context imbalance in 'afs_lookup_cell_rcu' - different lock contexts for basic block
+fs/afs/cell.c:532:17: warning: dereference of noderef expression
+  CC [M]  fs/afs/cell.o
+  CHECK   fs/afs/cmservice.c
+  CC [M]  fs/afs/cmservice.o
+  CHECK   fs/afs/dir.c
+fs/afs/dir.c:214:24: warning: context imbalance in 'afs_read_dir' - wrong count at exit
+fs/afs/dir.c:442:12: warning: context imbalance in 'afs_dir_iterate' - different lock contexts for basic block
+  CC [M]  fs/afs/dir.o
+  CHECK   fs/afs/dir_edit.c
+  CC [M]  fs/afs/dir_edit.o
+  CHECK   fs/afs/dir_silly.c
+  CC [M]  fs/afs/dir_silly.o
+  CHECK   fs/afs/dynroot.c
+fs/afs/dynroot.c:103:38: warning: context imbalance in 'afs_lookup_atcell' - different lock contexts for basic block
+  CC [M]  fs/afs/dynroot.o
+  CHECK   fs/afs/file.c
+  CC [M]  fs/afs/file.o
+  CHECK   fs/afs/flock.c
+  CC [M]  fs/afs/flock.o
+  CHECK   fs/afs/fsclient.c
+  CC [M]  fs/afs/fsclient.o
+  CHECK   fs/afs/fs_probe.c
+  CC [M]  fs/afs/fs_probe.o
+  CHECK   fs/afs/inode.c
+fs/afs/inode.c:609:34: error: incompatible types in comparison expression (different address spaces):
+fs/afs/inode.c:609:34:    struct afs_server [noderef] <asn:4> *
+fs/afs/inode.c:609:34:    struct afs_server *
+fs/afs/inode.c:603:38: warning: context imbalance in 'afs_check_validity' - different lock contexts for basic block
+fs/afs/inode.c:732:38: warning: context imbalance in 'afs_getattr' - different lock contexts for basic block
+  CC [M]  fs/afs/inode.o
+  CHECK   fs/afs/main.c
+  CC [M]  fs/afs/main.o
+  CHECK   fs/afs/misc.c
+  CC [M]  fs/afs/misc.o
+  CHECK   fs/afs/mntpt.c
+  CC [M]  fs/afs/mntpt.o
+  CHECK   fs/afs/rotate.c
+  CC [M]  fs/afs/rotate.o
+  CHECK   fs/afs/rxrpc.c
+  CC [M]  fs/afs/rxrpc.o
+  CHECK   fs/afs/security.c
+  CC [M]  fs/afs/security.o
+  CHECK   fs/afs/server.c
+fs/afs/server.c:52:17: warning: context imbalance in 'afs_find_server' - different lock contexts for basic block
+fs/afs/server.c:117:17: warning: context imbalance in 'afs_find_server_by_uuid' - different lock contexts for basic block
+  CC [M]  fs/afs/server.o
+  CHECK   fs/afs/server_list.c
+  CC [M]  fs/afs/server_list.o
+  CHECK   fs/afs/super.c
+  CC [M]  fs/afs/super.o
+  CHECK   fs/afs/vlclient.c
+  CC [M]  fs/afs/vlclient.o
+  CHECK   fs/afs/vl_list.c
+  CC [M]  fs/afs/vl_list.o
+  CHECK   fs/afs/vl_probe.c
+  CC [M]  fs/afs/vl_probe.o
+  CHECK   fs/afs/vl_rotate.c
+  CC [M]  fs/afs/vl_rotate.o
+  CHECK   fs/afs/volume.c
+fs/afs/volume.c:12:24: warning: symbol 'afs_volume_gc_delay' was not declared. Should it be static?
+fs/afs/volume.c:13:24: warning: symbol 'afs_volume_record_life' was not declared. Should it be static?
+  CC [M]  fs/afs/volume.o
+  CHECK   fs/afs/write.c
+  CC [M]  fs/afs/write.o
+  CHECK   fs/afs/xattr.c
+  CC [M]  fs/afs/xattr.o
+  CHECK   fs/afs/yfsclient.c
+  CC [M]  fs/afs/yfsclient.o
+  CHECK   fs/afs/proc.c
+  CC [M]  fs/afs/proc.o
+  LD [M]  fs/afs/kafs.o
+  CHECK   fs/autofs/init.c
+  CC [M]  fs/autofs/init.o
+  CHECK   fs/autofs/inode.c
+  CC [M]  fs/autofs/inode.o
+  CHECK   fs/autofs/root.c
+  CC [M]  fs/autofs/root.o
+  CHECK   fs/autofs/symlink.c
+  CC [M]  fs/autofs/symlink.o
+  CHECK   fs/autofs/waitq.c
+  CC [M]  fs/autofs/waitq.o
+  CHECK   fs/autofs/expire.c
+  CC [M]  fs/autofs/expire.o
+  CHECK   fs/autofs/dev-ioctl.c
+  CC [M]  fs/autofs/dev-ioctl.o
+  LD [M]  fs/autofs/autofs4.o
+  CHECK   fs/befs/datastream.c
+  CC [M]  fs/befs/datastream.o
+  CHECK   fs/befs/btree.c
+  CC [M]  fs/befs/btree.o
+  CHECK   fs/befs/super.c
+  CC [M]  fs/befs/super.o
+  CHECK   fs/befs/inode.c
+  CC [M]  fs/befs/inode.o
+  CHECK   fs/befs/debug.c
+  CC [M]  fs/befs/debug.o
+  CHECK   fs/befs/io.c
+  CC [M]  fs/befs/io.o
+  CHECK   fs/befs/linuxvfs.c
+  CC [M]  fs/befs/linuxvfs.o
+  LD [M]  fs/befs/befs.o
+  CHECK   fs/bfs/inode.c
+fs/bfs/inode.c:415:36: warning: cast to restricted __le32
+  CC [M]  fs/bfs/inode.o
+  CHECK   fs/bfs/file.c
+  CC [M]  fs/bfs/file.o
+  CHECK   fs/bfs/dir.c
+  CC [M]  fs/bfs/dir.o
+  LD [M]  fs/bfs/bfs.o
+  CHECK   fs/btrfs/super.c
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast from restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: incorrect type in argument 3 (different base types)
+./include/trace/events/btrfs.h:1317:1:    expected unsigned long flags
+./include/trace/events/btrfs.h:1317:1:    got restricted gfp_t [usertype] mask
+./include/trace/events/btrfs.h:1317:1: warning: cast to restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: cast to restricted gfp_t
+./include/trace/events/btrfs.h:1317:1: warning: restricted gfp_t degrades to integer
+./include/trace/events/btrfs.h:1317:1: warning: restricted gfp_t degrades to integer
+  CC [M]  fs/btrfs/super.o
+  CHECK   fs/btrfs/ctree.c
+fs/btrfs/ctree.c:128:22: error: incompatible types in comparison expression (different address spaces):
+fs/btrfs/ctree.c:128:22:    struct extent_buffer [noderef] <asn:4> *
+fs/btrfs/ctree.c:128:22:    struct extent_buffer *
+fs/btrfs/ctree.c:1127:17: error: incompatible types in comparison expression (different address spaces):
+fs/btrfs/ctree.c:1127:17:    struct extent_buffer [noderef] <asn:4> *
+fs/btrfs/ctree.c:1127:17:    struct extent_buffer *
+fs/btrfs/ctree.c:1901:17: error: incompatible types in comparison expression (different address spaces):
+fs/btrfs/ctree.c:1901:17:    struct extent_buffer [noderef] <asn:4> *
+fs/btrfs/ctree.c:1901:17:    struct extent_buffer *
+fs/btrfs/ctree.c:3393:9: error: incompatible types in comparison expression (different address spaces):
+fs/btrfs/ctree.c:3393:9:    struct extent_buffer [noderef] <asn:4> *
+fs/btrfs/ctree.c:3393:9:    struct extent_buffer *
+fs/btrfs/ctree.c:583:17: warning: context imbalance in 'tree_mod_log_insert_move' - unexpected unlock
+fs/btrfs/ctree.c:810:17: warning: context imbalance in 'tree_mod_log_eb_copy' - unexpected unlock
+  CC [M]  fs/btrfs/ctree.o
+  CHECK   fs/btrfs/extent-tree.c
+fs/btrfs/extent-tree.c:1787:9: warning: context imbalance in 'run_and_cleanup_extent_op' - unexpected unlock
+fs/btrfs/extent-tree.c:1860:28: warning: context imbalance in 'cleanup_ref_head' - unexpected unlock
+fs/btrfs/extent-tree.c:1937:36: warning: context imbalance in 'btrfs_run_delayed_refs_for_head' - unexpected unlock
+fs/btrfs/extent-tree.c:2002:21: warning: context imbalance in '__btrfs_run_delayed_refs' - wrong count at exit
+fs/btrfs/extent-tree.c:3387:33: warning: context imbalance in 'btrfs_lock_cluster' - wrong count at exit
+fs/btrfs/extent-tree.c:3541:28: warning: context imbalance in 'find_free_extent_clustered' - unexpected unlock
+  CC [M]  fs/btrfs/extent-tree.o
+  CHECK   fs/btrfs/print-tree.c
+  CC [M]  fs/btrfs/print-tree.o
+  CHECK   fs/btrfs/root-tree.c
+  CC [M]  fs/btrfs/root-tree.o
+  CHECK   fs/btrfs/dir-item.c
+  CC [M]  fs/btrfs/dir-item.o
+  CHECK   fs/btrfs/file-item.c
+  CC [M]  fs/btrfs/file-item.o
+  CHECK   fs/btrfs/inode-item.c
+  CC [M]  fs/btrfs/inode-item.o
+  CHECK   fs/btrfs/inode-map.c
+  CC [M]  fs/btrfs/inode-map.o
+  CHECK   fs/btrfs/disk-io.c
+  CC [M]  fs/btrfs/disk-io.o
+  CHECK   fs/btrfs/transaction.c
+  CC [M]  fs/btrfs/transaction.o
+  CHECK   fs/btrfs/inode.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/btrfs/inode.o
+  CHECK   fs/btrfs/file.c
+  CC [M]  fs/btrfs/file.o
+  CHECK   fs/btrfs/tree-defrag.c
+  CC [M]  fs/btrfs/tree-defrag.o
+  CHECK   fs/btrfs/extent_map.c
+  CC [M]  fs/btrfs/extent_map.o
+  CHECK   fs/btrfs/sysfs.c
+fs/btrfs/sysfs.c:366:9: warning: context imbalance in 'btrfs_show_u64' - different lock contexts for basic block
+  CC [M]  fs/btrfs/sysfs.o
+  CHECK   fs/btrfs/struct-funcs.c
+  CC [M]  fs/btrfs/struct-funcs.o
+  CHECK   fs/btrfs/xattr.c
+  CC [M]  fs/btrfs/xattr.o
+  CHECK   fs/btrfs/ordered-data.c
+  CC [M]  fs/btrfs/ordered-data.o
+  CHECK   fs/btrfs/extent_io.c
+./include/linux/page-flags.h:174:30: warning: context imbalance in 'btrfs_release_extent_buffer_pages' - different lock contexts for basic block
+./arch/x86/include/asm/atomic.h:125:16: warning: context imbalance in 'release_extent_buffer' - unexpected unlock
+fs/btrfs/extent_io.c:5270:6: warning: context imbalance in 'free_extent_buffer' - wrong count at exit
+fs/btrfs/extent_io.c:5302:6: warning: context imbalance in 'free_extent_buffer_stale' - wrong count at exit
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/btrfs/extent_io.o
+  CHECK   fs/btrfs/volumes.c
+fs/btrfs/volumes.c:366:31: warning: incorrect type in argument 1 (different address spaces)
+fs/btrfs/volumes.c:366:31:    expected struct rcu_string *str
+fs/btrfs/volumes.c:366:31:    got struct rcu_string [noderef] <asn:4> *name
+fs/btrfs/volumes.c:613:43: warning: incorrect type in argument 1 (different address spaces)
+fs/btrfs/volumes.c:613:43:    expected char const *device_path
+fs/btrfs/volumes.c:613:43:    got char [noderef] <asn:4> *
+fs/btrfs/volumes.c:834:50: warning: incorrect type in argument 1 (different address spaces)
+fs/btrfs/volumes.c:834:50:    expected char const *
+fs/btrfs/volumes.c:834:50:    got char [noderef] <asn:4> *
+fs/btrfs/volumes.c:907:39: warning: incorrect type in argument 1 (different address spaces)
+fs/btrfs/volumes.c:907:39:    expected struct rcu_string *str
+fs/btrfs/volumes.c:907:39:    got struct rcu_string [noderef] <asn:4> *name
+fs/btrfs/volumes.c:962:58: warning: incorrect type in argument 1 (different address spaces)
+fs/btrfs/volumes.c:962:58:    expected char const *src
+fs/btrfs/volumes.c:962:58:    got char [noderef] <asn:4> *
+fs/btrfs/volumes.c:1090:48: warning: incorrect type in argument 1 (different address spaces)
+fs/btrfs/volumes.c:1090:48:    expected char const *src
+fs/btrfs/volumes.c:1090:48:    got char [noderef] <asn:4> *
+fs/btrfs/volumes.c:2028:63: warning: incorrect type in argument 2 (different address spaces)
+fs/btrfs/volumes.c:2028:63:    expected char const *device_path
+fs/btrfs/volumes.c:2028:63:    got char [noderef] <asn:4> *
+fs/btrfs/volumes.c:2096:63: warning: incorrect type in argument 2 (different address spaces)
+fs/btrfs/volumes.c:2096:63:    expected char const *device_path
+fs/btrfs/volumes.c:2096:63:    got char [noderef] <asn:4> *
+fs/btrfs/volumes.c:2156:55: warning: incorrect type in argument 2 (different address spaces)
+fs/btrfs/volumes.c:2156:55:    expected char const *device_path
+fs/btrfs/volumes.c:2156:55:    got char [noderef] <asn:4> *
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/btrfs/volumes.o
+  CHECK   fs/btrfs/async-thread.c
+  CC [M]  fs/btrfs/async-thread.o
+  CHECK   fs/btrfs/ioctl.c
+  CC [M]  fs/btrfs/ioctl.o
+  CHECK   fs/btrfs/locking.c
+./include/linux/kasan-checks.h:38:20: warning: context imbalance in 'btrfs_set_lock_blocking_read' - unexpected unlock
+fs/btrfs/locking.c:232:41: warning: context imbalance in 'btrfs_set_lock_blocking_write' - unexpected unlock
+fs/btrfs/locking.c:247:6: warning: context imbalance in 'btrfs_tree_read_lock' - different lock contexts for basic block
+fs/btrfs/locking.c:288:5: warning: context imbalance in 'btrfs_tree_read_lock_atomic' - different lock contexts for basic block
+fs/btrfs/locking.c:310:5: warning: context imbalance in 'btrfs_try_tree_read_lock' - different lock contexts for basic block
+fs/btrfs/locking.c:335:5: warning: context imbalance in 'btrfs_try_tree_write_lock' - different lock contexts for basic block
+./include/linux/kasan-checks.h:38:20: warning: context imbalance in 'btrfs_tree_read_unlock' - unexpected unlock
+fs/btrfs/locking.c:412:6: warning: context imbalance in 'btrfs_tree_lock' - wrong count at exit
+fs/btrfs/locking.c:129:9: warning: context imbalance in 'btrfs_tree_unlock' - unexpected unlock
+  CC [M]  fs/btrfs/locking.o
+  CHECK   fs/btrfs/orphan.c
+  CC [M]  fs/btrfs/orphan.o
+  CHECK   fs/btrfs/export.c
+  CC [M]  fs/btrfs/export.o
+  CHECK   fs/btrfs/tree-log.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/btrfs/tree-log.o
+  CHECK   fs/btrfs/free-space-cache.c
+fs/btrfs/free-space-cache.c:992:9: warning: context imbalance in 'write_cache_extent_entries' - different lock contexts for basic block
+fs/btrfs/free-space-cache.c:2129:28: warning: context imbalance in 'insert_into_bitmap' - unexpected unlock
+  CC [M]  fs/btrfs/free-space-cache.o
+  CHECK   fs/btrfs/zlib.c
+fs/btrfs/zlib.c:32:18: warning: symbol 'zlib_get_workspace' was not declared. Should it be static?
+fs/btrfs/zlib.c:42:6: warning: symbol 'zlib_free_workspace' was not declared. Should it be static?
+fs/btrfs/zlib.c:51:18: warning: symbol 'zlib_alloc_workspace' was not declared. Should it be static?
+fs/btrfs/zlib.c:76:5: warning: symbol 'zlib_compress_pages' was not declared. Should it be static?
+fs/btrfs/zlib.c:212:5: warning: symbol 'zlib_decompress_bio' was not declared. Should it be static?
+fs/btrfs/zlib.c:303:5: warning: symbol 'zlib_decompress' was not declared. Should it be static?
+  CC [M]  fs/btrfs/zlib.o
+  CHECK   fs/btrfs/lzo.c
+fs/btrfs/lzo.c:66:6: warning: symbol 'lzo_free_workspace' was not declared. Should it be static?
+fs/btrfs/lzo.c:76:18: warning: symbol 'lzo_alloc_workspace' was not declared. Should it be static?
+fs/btrfs/lzo.c:114:5: warning: symbol 'lzo_compress_pages' was not declared. Should it be static?
+fs/btrfs/lzo.c:282:5: warning: symbol 'lzo_decompress_bio' was not declared. Should it be static?
+fs/btrfs/lzo.c:423:5: warning: symbol 'lzo_decompress' was not declared. Should it be static?
+  CC [M]  fs/btrfs/lzo.o
+  CHECK   fs/btrfs/zstd.c
+fs/btrfs/zstd.c:170:6: warning: symbol 'zstd_init_workspace_manager' was not declared. Should it be static?
+fs/btrfs/zstd.c:196:6: warning: symbol 'zstd_cleanup_workspace_manager' was not declared. Should it be static?
+fs/btrfs/zstd.c:263:18: warning: symbol 'zstd_get_workspace' was not declared. Should it be static?
+fs/btrfs/zstd.c:304:6: warning: symbol 'zstd_put_workspace' was not declared. Should it be static?
+fs/btrfs/zstd.c:369:5: warning: symbol 'zstd_compress_pages' was not declared. Should it be static?
+fs/btrfs/zstd.c:546:5: warning: symbol 'zstd_decompress_bio' was not declared. Should it be static?
+fs/btrfs/zstd.c:624:5: warning: symbol 'zstd_decompress' was not declared. Should it be static?
+  CC [M]  fs/btrfs/zstd.o
+  CHECK   fs/btrfs/compression.c
+  CC [M]  fs/btrfs/compression.o
+  CHECK   fs/btrfs/delayed-ref.c
+  CC [M]  fs/btrfs/delayed-ref.o
+  CHECK   fs/btrfs/relocation.c
+  CC [M]  fs/btrfs/relocation.o
+  CHECK   fs/btrfs/delayed-inode.c
+  CC [M]  fs/btrfs/delayed-inode.o
+  CHECK   fs/btrfs/scrub.c
+  CC [M]  fs/btrfs/scrub.o
+  CHECK   fs/btrfs/reada.c
+  CC [M]  fs/btrfs/reada.o
+  CHECK   fs/btrfs/backref.c
+  CC [M]  fs/btrfs/backref.o
+  CHECK   fs/btrfs/ulist.c
+  CC [M]  fs/btrfs/ulist.o
+  CHECK   fs/btrfs/qgroup.c
+  CC [M]  fs/btrfs/qgroup.o
+  CHECK   fs/btrfs/send.c
+  CC [M]  fs/btrfs/send.o
+  CHECK   fs/btrfs/dev-replace.c
+  CC [M]  fs/btrfs/dev-replace.o
+  CHECK   fs/btrfs/raid56.c
+  CC [M]  fs/btrfs/raid56.o
+  CHECK   fs/btrfs/uuid-tree.c
+  CC [M]  fs/btrfs/uuid-tree.o
+  CHECK   fs/btrfs/props.c
+  CC [M]  fs/btrfs/props.o
+  CHECK   fs/btrfs/free-space-tree.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/btrfs/free-space-tree.o
+  CHECK   fs/btrfs/tree-checker.c
+  CC [M]  fs/btrfs/tree-checker.o
+  CHECK   fs/btrfs/space-info.c
+  CC [M]  fs/btrfs/space-info.o
+  CHECK   fs/btrfs/block-rsv.c
+  CC [M]  fs/btrfs/block-rsv.o
+  CHECK   fs/btrfs/delalloc-space.c
+  CC [M]  fs/btrfs/delalloc-space.o
+  CHECK   fs/btrfs/block-group.c
+fs/btrfs/block-group.c:3068:9: warning: context imbalance in 'btrfs_put_block_group_cache' - wrong count at exit
+  CC [M]  fs/btrfs/block-group.o
+  CHECK   fs/btrfs/acl.c
+  CC [M]  fs/btrfs/acl.o
+  CHECK   fs/btrfs/check-integrity.c
+  CC [M]  fs/btrfs/check-integrity.o
+  CHECK   fs/btrfs/ref-verify.c
+fs/btrfs/ref-verify.c:260:27: warning: context imbalance in 'add_block_entry' - different lock contexts for basic block
+fs/btrfs/ref-verify.c:347:20: warning: context imbalance in 'add_tree_block' - unexpected unlock
+fs/btrfs/ref-verify.c:372:28: warning: context imbalance in 'add_shared_data_ref' - unexpected unlock
+fs/btrfs/ref-verify.c:410:28: warning: context imbalance in 'add_extent_data_ref' - unexpected unlock
+fs/btrfs/ref-verify.c:881:20: warning: context imbalance in 'btrfs_ref_tree_mod' - unexpected unlock
+  CC [M]  fs/btrfs/ref-verify.o
+  CHECK   fs/btrfs/tests/free-space-tests.c
+  CC [M]  fs/btrfs/tests/free-space-tests.o
+  CHECK   fs/btrfs/tests/extent-buffer-tests.c
+  CC [M]  fs/btrfs/tests/extent-buffer-tests.o
+  CHECK   fs/btrfs/tests/btrfs-tests.c
+fs/btrfs/tests/btrfs-tests.c:164:9: warning: incorrect type in assignment (different address spaces)
+fs/btrfs/tests/btrfs-tests.c:164:9:    expected void **slot
+fs/btrfs/tests/btrfs-tests.c:164:9:    got void [noderef] <asn:4> **
+fs/btrfs/tests/btrfs-tests.c:164:9: warning: incorrect type in assignment (different address spaces)
+fs/btrfs/tests/btrfs-tests.c:164:9:    expected void **slot
+fs/btrfs/tests/btrfs-tests.c:164:9:    got void [noderef] <asn:4> **
+fs/btrfs/tests/btrfs-tests.c:167:54: warning: incorrect type in argument 1 (different address spaces)
+fs/btrfs/tests/btrfs-tests.c:167:54:    expected void [noderef] <asn:4> **slot
+fs/btrfs/tests/btrfs-tests.c:167:54:    got void **slot
+fs/btrfs/tests/btrfs-tests.c:173:38: warning: incorrect type in assignment (different address spaces)
+fs/btrfs/tests/btrfs-tests.c:173:38:    expected void **slot
+fs/btrfs/tests/btrfs-tests.c:173:38:    got void [noderef] <asn:4> **
+fs/btrfs/tests/btrfs-tests.c:176:47: warning: incorrect type in argument 1 (different address spaces)
+fs/btrfs/tests/btrfs-tests.c:176:47:    expected void [noderef] <asn:4> **slot
+fs/btrfs/tests/btrfs-tests.c:176:47:    got void **slot
+fs/btrfs/tests/btrfs-tests.c:176:22: warning: incorrect type in assignment (different address spaces)
+fs/btrfs/tests/btrfs-tests.c:176:22:    expected void **slot
+fs/btrfs/tests/btrfs-tests.c:176:22:    got void [noderef] <asn:4> **
+fs/btrfs/tests/btrfs-tests.c:164:9: warning: incorrect type in argument 1 (different address spaces)
+fs/btrfs/tests/btrfs-tests.c:164:9:    expected void [noderef] <asn:4> **slot
+fs/btrfs/tests/btrfs-tests.c:164:9:    got void **slot
+fs/btrfs/tests/btrfs-tests.c:164:9: warning: incorrect type in assignment (different address spaces)
+fs/btrfs/tests/btrfs-tests.c:164:9:    expected void **slot
+fs/btrfs/tests/btrfs-tests.c:164:9:    got void [noderef] <asn:4> **
+  CC [M]  fs/btrfs/tests/btrfs-tests.o
+  CHECK   fs/btrfs/tests/extent-io-tests.c
+  CC [M]  fs/btrfs/tests/extent-io-tests.o
+  CHECK   fs/btrfs/tests/inode-tests.c
+  CC [M]  fs/btrfs/tests/inode-tests.o
+  CHECK   fs/btrfs/tests/qgroup-tests.c
+  CC [M]  fs/btrfs/tests/qgroup-tests.o
+  CHECK   fs/btrfs/tests/free-space-tree-tests.c
+  CC [M]  fs/btrfs/tests/free-space-tree-tests.o
+  CHECK   fs/btrfs/tests/extent-map-tests.c
+  CC [M]  fs/btrfs/tests/extent-map-tests.o
+  LD [M]  fs/btrfs/btrfs.o
+  CHECK   fs/cachefiles/bind.c
+  CC [M]  fs/cachefiles/bind.o
+  CHECK   fs/cachefiles/daemon.c
+  CC [M]  fs/cachefiles/daemon.o
+  CHECK   fs/cachefiles/interface.c
+  CC [M]  fs/cachefiles/interface.o
+  CHECK   fs/cachefiles/key.c
+  CC [M]  fs/cachefiles/key.o
+  CHECK   fs/cachefiles/main.c
+  CC [M]  fs/cachefiles/main.o
+  CHECK   fs/cachefiles/namei.c
+  CC [M]  fs/cachefiles/namei.o
+  CHECK   fs/cachefiles/rdwr.c
+  CC [M]  fs/cachefiles/rdwr.o
+  CHECK   fs/cachefiles/security.c
+  CC [M]  fs/cachefiles/security.o
+  CHECK   fs/cachefiles/xattr.c
+  CC [M]  fs/cachefiles/xattr.o
+  CHECK   fs/cachefiles/proc.c
+  CC [M]  fs/cachefiles/proc.o
+  LD [M]  fs/cachefiles/cachefiles.o
+  CHECK   fs/ceph/super.c
+  CC [M]  fs/ceph/super.o
+  CHECK   fs/ceph/inode.c
+  CC [M]  fs/ceph/inode.o
+  CHECK   fs/ceph/dir.c
+  CC [M]  fs/ceph/dir.o
+  CHECK   fs/ceph/file.c
+  CC [M]  fs/ceph/file.o
+  CHECK   fs/ceph/locks.c
+  CC [M]  fs/ceph/locks.o
+  CHECK   fs/ceph/addr.c
+  CC [M]  fs/ceph/addr.o
+  CHECK   fs/ceph/ioctl.c
+  CC [M]  fs/ceph/ioctl.o
+  CHECK   fs/ceph/export.c
+  CC [M]  fs/ceph/export.o
+  CHECK   fs/ceph/caps.c
+fs/ceph/caps.c:3355:9: warning: context imbalance in 'handle_cap_grant' - wrong count at exit
+fs/ceph/caps.c:3961:17: warning: context imbalance in 'ceph_handle_caps' - unexpected unlock
+  CC [M]  fs/ceph/caps.o
+  CHECK   fs/ceph/snap.c
+  CC [M]  fs/ceph/snap.o
+  CHECK   fs/ceph/xattr.c
+  CC [M]  fs/ceph/xattr.o
+  CHECK   fs/ceph/quota.c
+  CC [M]  fs/ceph/quota.o
+  CHECK   fs/ceph/io.c
+  CC [M]  fs/ceph/io.o
+  CHECK   fs/ceph/mds_client.c
+  CC [M]  fs/ceph/mds_client.o
+  CHECK   fs/ceph/mdsmap.c
+  CC [M]  fs/ceph/mdsmap.o
+  CHECK   fs/ceph/strings.c
+  CC [M]  fs/ceph/strings.o
+  CHECK   fs/ceph/ceph_frag.c
+  CC [M]  fs/ceph/ceph_frag.o
+  CHECK   fs/ceph/debugfs.c
+  CC [M]  fs/ceph/debugfs.o
+  CHECK   fs/ceph/cache.c
+  CC [M]  fs/ceph/cache.o
+  CHECK   fs/ceph/acl.c
+  CC [M]  fs/ceph/acl.o
+  LD [M]  fs/ceph/ceph.o
+  CHECK   fs/cifs/trace.c
+  CC [M]  fs/cifs/trace.o
+  CHECK   fs/cifs/cifsfs.c
+fs/cifs/cifsglob.h:1835:41: warning: symbol 'cifs_tcp_ses_list' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1846:41: warning: symbol 'cifs_tcp_ses_lock' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1858:28: warning: symbol 'GlobalCurrentXid' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1859:28: warning: symbol 'GlobalTotalActiveXid' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1860:28: warning: symbol 'GlobalMaxActiveXid' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1861:26: warning: symbol 'GlobalMid_Lock' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1866:24: warning: symbol 'sesInfoAllocCount' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1867:24: warning: symbol 'tconInfoAllocCount' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1868:24: warning: symbol 'tcpSesAllocCount' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1869:24: warning: symbol 'tcpSesReconnectCount' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1870:24: warning: symbol 'tconInfoReconnectCount' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1873:24: warning: symbol 'bufAllocCount' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1875:24: warning: symbol 'totBufAllocCount' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1876:24: warning: symbol 'totSmBufAllocCount' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1879:24: warning: symbol 'smBufAllocCount' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1880:24: warning: symbol 'midCount' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1895:30: warning: symbol 'uidtree' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1896:30: warning: symbol 'gidtree' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1897:26: warning: symbol 'siduidlock' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1898:26: warning: symbol 'sidgidlock' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1899:30: warning: symbol 'siduidtree' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1900:30: warning: symbol 'sidgidtree' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1901:26: warning: symbol 'uidsidlock' was not declared. Should it be static?
+fs/cifs/cifsglob.h:1902:26: warning: symbol 'gidsidlock' was not declared. Should it be static?
+  CC [M]  fs/cifs/cifsfs.o
+  CHECK   fs/cifs/cifssmb.c
+  CC [M]  fs/cifs/cifssmb.o
+  CHECK   fs/cifs/cifs_debug.c
+  CC [M]  fs/cifs/cifs_debug.o
+  CHECK   fs/cifs/connect.c
+  CC [M]  fs/cifs/connect.o
+  CHECK   fs/cifs/dir.c
+  CC [M]  fs/cifs/dir.o
+  CHECK   fs/cifs/file.c
+  CC [M]  fs/cifs/file.o
+  CHECK   fs/cifs/inode.c
+  CC [M]  fs/cifs/inode.o
+  CHECK   fs/cifs/link.c
+  CC [M]  fs/cifs/link.o
+  CHECK   fs/cifs/misc.c
+  CC [M]  fs/cifs/misc.o
+  CHECK   fs/cifs/netmisc.c
+  CC [M]  fs/cifs/netmisc.o
+  CHECK   fs/cifs/smbencrypt.c
+  CC [M]  fs/cifs/smbencrypt.o
+  CHECK   fs/cifs/transport.c
+  CC [M]  fs/cifs/transport.o
+  CHECK   fs/cifs/asn1.c
+  CC [M]  fs/cifs/asn1.o
+  CHECK   fs/cifs/cifs_unicode.c
+  CC [M]  fs/cifs/cifs_unicode.o
+  CHECK   fs/cifs/nterr.c
+  CC [M]  fs/cifs/nterr.o
+  CHECK   fs/cifs/cifsencrypt.c
+  CC [M]  fs/cifs/cifsencrypt.o
+  CHECK   fs/cifs/readdir.c
+  CC [M]  fs/cifs/readdir.o
+  CHECK   fs/cifs/ioctl.c
+  CC [M]  fs/cifs/ioctl.o
+  CHECK   fs/cifs/sess.c
+  CC [M]  fs/cifs/sess.o
+  CHECK   fs/cifs/export.c
+  CC [M]  fs/cifs/export.o
+  CHECK   fs/cifs/smb1ops.c
+  CC [M]  fs/cifs/smb1ops.o
+  CHECK   fs/cifs/winucase.c
+  CC [M]  fs/cifs/winucase.o
+  CHECK   fs/cifs/smb2ops.c
+  CC [M]  fs/cifs/smb2ops.o
+  CHECK   fs/cifs/smb2maperror.c
+  CC [M]  fs/cifs/smb2maperror.o
+  CHECK   fs/cifs/smb2transport.c
+  CC [M]  fs/cifs/smb2transport.o
+  CHECK   fs/cifs/smb2misc.c
+  CC [M]  fs/cifs/smb2misc.o
+  CHECK   fs/cifs/smb2pdu.c
+  CC [M]  fs/cifs/smb2pdu.o
+  CHECK   fs/cifs/smb2inode.c
+  CC [M]  fs/cifs/smb2inode.o
+  CHECK   fs/cifs/smb2file.c
+  CC [M]  fs/cifs/smb2file.o
+  CHECK   fs/cifs/cifsacl.c
+  CC [M]  fs/cifs/cifsacl.o
+  CHECK   fs/cifs/xattr.c
+  CC [M]  fs/cifs/xattr.o
+  CHECK   fs/cifs/cifs_spnego.c
+  CC [M]  fs/cifs/cifs_spnego.o
+  CHECK   fs/cifs/dns_resolve.c
+  CC [M]  fs/cifs/dns_resolve.o
+  CHECK   fs/cifs/cifs_dfs_ref.c
+  CC [M]  fs/cifs/cifs_dfs_ref.o
+  CHECK   fs/cifs/dfs_cache.c
+  CC [M]  fs/cifs/dfs_cache.o
+  CHECK   fs/cifs/fscache.c
+  CC [M]  fs/cifs/fscache.o
+  CHECK   fs/cifs/cache.c
+  CC [M]  fs/cifs/cache.o
+  CHECK   fs/cifs/smbdirect.c
+  CC [M]  fs/cifs/smbdirect.o
+  LD [M]  fs/cifs/cifs.o
+  CHECK   fs/coda/psdev.c
+  CC [M]  fs/coda/psdev.o
+  CHECK   fs/coda/cache.c
+  CC [M]  fs/coda/cache.o
+  CHECK   fs/coda/cnode.c
+  CC [M]  fs/coda/cnode.o
+  CHECK   fs/coda/inode.c
+  CC [M]  fs/coda/inode.o
+  CHECK   fs/coda/dir.c
+  CC [M]  fs/coda/dir.o
+  CHECK   fs/coda/file.c
+  CC [M]  fs/coda/file.o
+  CHECK   fs/coda/upcall.c
+  CC [M]  fs/coda/upcall.o
+  CHECK   fs/coda/coda_linux.c
+fs/coda/coda_linux.c:25:5: warning: symbol 'coda_fake_statfs' was not declared. Should it be static?
+  CC [M]  fs/coda/coda_linux.o
+  CHECK   fs/coda/symlink.c
+  CC [M]  fs/coda/symlink.o
+  CHECK   fs/coda/pioctl.c
+  CC [M]  fs/coda/pioctl.o
+  CHECK   fs/coda/sysctl.c
+  CC [M]  fs/coda/sysctl.o
+  LD [M]  fs/coda/coda.o
+  CHECK   fs/configfs/inode.c
+  CC      fs/configfs/inode.o
+  CHECK   fs/configfs/file.c
+  CC      fs/configfs/file.o
+  CHECK   fs/configfs/dir.c
+  CC      fs/configfs/dir.o
+  CHECK   fs/configfs/symlink.c
+  CC      fs/configfs/symlink.o
+  CHECK   fs/configfs/mount.c
+  CC      fs/configfs/mount.o
+  CHECK   fs/configfs/item.c
+  CC      fs/configfs/item.o
+  AR      fs/configfs/built-in.a
+  CHECK   fs/cramfs/inode.c
+  CC [M]  fs/cramfs/inode.o
+  CHECK   fs/cramfs/uncompress.c
+  CC [M]  fs/cramfs/uncompress.o
+  LD [M]  fs/cramfs/cramfs.o
+  CHECK   fs/crypto/crypto.c
+  CC      fs/crypto/crypto.o
+  CHECK   fs/crypto/fname.c
+  CC      fs/crypto/fname.o
+  CHECK   fs/crypto/hkdf.c
+  CC      fs/crypto/hkdf.o
+  CHECK   fs/crypto/hooks.c
+  CC      fs/crypto/hooks.o
+  CHECK   fs/crypto/keyring.c
+  CC      fs/crypto/keyring.o
+  CHECK   fs/crypto/keysetup.c
+  CC      fs/crypto/keysetup.o
+  CHECK   fs/crypto/keysetup_v1.c
+fs/crypto/keysetup_v1.c:166:17: warning: context imbalance in 'fscrypt_put_direct_key' - unexpected unlock
+  CC      fs/crypto/keysetup_v1.o
+  CHECK   fs/crypto/policy.c
+  CC      fs/crypto/policy.o
+  CHECK   fs/crypto/bio.c
+  CC      fs/crypto/bio.o
+  AR      fs/crypto/built-in.a
+  CHECK   fs/debugfs/inode.c
+  CC      fs/debugfs/inode.o
+  CHECK   fs/debugfs/file.c
+  CC      fs/debugfs/file.o
+  AR      fs/debugfs/built-in.a
+  CHECK   fs/devpts/inode.c
+  CC      fs/devpts/inode.o
+  AR      fs/devpts/built-in.a
+  CHECK   fs/dlm/ast.c
+  CC [M]  fs/dlm/ast.o
+  CHECK   fs/dlm/config.c
+  CC [M]  fs/dlm/config.o
+  CHECK   fs/dlm/dir.c
+  CC [M]  fs/dlm/dir.o
+  CHECK   fs/dlm/lock.c
+fs/dlm/lock.c:1047:9: warning: context imbalance in 'dlm_master_lookup' - different lock contexts for basic block
+  CC [M]  fs/dlm/lock.o
+  CHECK   fs/dlm/lockspace.c
+  CC [M]  fs/dlm/lockspace.o
+  CHECK   fs/dlm/main.c
+  CC [M]  fs/dlm/main.o
+  CHECK   fs/dlm/member.c
+fs/dlm/member.c:123:31: warning: incorrect type in assignment (different base types)
+fs/dlm/member.c:123:31:    expected restricted __le32 [usertype] ro_nodeid
+fs/dlm/member.c:123:31:    got unsigned int [usertype]
+fs/dlm/member.c:124:29: warning: incorrect type in assignment (different base types)
+fs/dlm/member.c:124:29:    expected restricted __le16 [usertype] ro_slot
+fs/dlm/member.c:124:29:    got unsigned short [usertype]
+fs/dlm/member.c:131:31: warning: restricted __le32 degrades to integer
+fs/dlm/member.c:133:36: warning: incorrect type in assignment (different base types)
+fs/dlm/member.c:133:36:    expected int slot
+fs/dlm/member.c:133:36:    got restricted __le16 [usertype] ro_slot
+  CC [M]  fs/dlm/member.o
+  CHECK   fs/dlm/memory.c
+  CC [M]  fs/dlm/memory.o
+  CHECK   fs/dlm/midcomms.c
+fs/dlm/midcomms.c:79:26: warning: cast to restricted __le16
+  CC [M]  fs/dlm/midcomms.o
+  CHECK   fs/dlm/netlink.c
+  CC [M]  fs/dlm/netlink.o
+  CHECK   fs/dlm/lowcomms.c
+  CC [M]  fs/dlm/lowcomms.o
+  CHECK   fs/dlm/plock.c
+  CC [M]  fs/dlm/plock.o
+  CHECK   fs/dlm/rcom.c
+  CC [M]  fs/dlm/rcom.o
+  CHECK   fs/dlm/recover.c
+  CC [M]  fs/dlm/recover.o
+  CHECK   fs/dlm/recoverd.c
+  CC [M]  fs/dlm/recoverd.o
+  CHECK   fs/dlm/requestqueue.c
+  CC [M]  fs/dlm/requestqueue.o
+  CHECK   fs/dlm/user.c
+fs/dlm/user.c:111:38: warning: incorrect type in assignment (different address spaces)
+fs/dlm/user.c:111:38:    expected void [noderef] <asn:1> *castparam
+fs/dlm/user.c:111:38:    got void *
+fs/dlm/user.c:112:37: warning: incorrect type in assignment (different address spaces)
+fs/dlm/user.c:112:37:    expected void [noderef] <asn:1> *castaddr
+fs/dlm/user.c:112:37:    got void *
+fs/dlm/user.c:113:38: warning: incorrect type in assignment (different address spaces)
+fs/dlm/user.c:113:38:    expected void [noderef] <asn:1> *bastparam
+fs/dlm/user.c:113:38:    got void *
+fs/dlm/user.c:114:37: warning: incorrect type in assignment (different address spaces)
+fs/dlm/user.c:114:37:    expected void [noderef] <asn:1> *bastaddr
+fs/dlm/user.c:114:37:    got void *
+fs/dlm/user.c:115:33: warning: incorrect type in assignment (different address spaces)
+fs/dlm/user.c:115:33:    expected struct dlm_lksb [noderef] <asn:1> *lksb
+fs/dlm/user.c:115:33:    got void *
+fs/dlm/user.c:130:39: warning: cast removes address space '<asn:1>' of expression
+fs/dlm/user.c:131:40: warning: cast removes address space '<asn:1>' of expression
+fs/dlm/user.c:132:36: warning: cast removes address space '<asn:1>' of expression
+  CC [M]  fs/dlm/user.o
+  CHECK   fs/dlm/util.c
+fs/dlm/util.c:25:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:25:33:    expected unsigned int [usertype] h_version
+fs/dlm/util.c:25:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:26:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:26:33:    expected unsigned int [usertype] h_lockspace
+fs/dlm/util.c:26:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:27:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:27:33:    expected unsigned int [usertype] h_nodeid
+fs/dlm/util.c:27:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:28:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:28:33:    expected unsigned short [usertype] h_length
+fs/dlm/util.c:28:33:    got restricted __le16 [usertype]
+fs/dlm/util.c:33:35: warning: cast to restricted __le32
+fs/dlm/util.c:34:35: warning: cast to restricted __le32
+fs/dlm/util.c:35:35: warning: cast to restricted __le32
+fs/dlm/util.c:36:35: warning: cast to restricted __le16
+fs/dlm/util.c:88:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:88:33:    expected unsigned int [usertype] m_type
+fs/dlm/util.c:88:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:89:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:89:33:    expected unsigned int [usertype] m_nodeid
+fs/dlm/util.c:89:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:90:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:90:33:    expected unsigned int [usertype] m_pid
+fs/dlm/util.c:90:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:91:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:91:33:    expected unsigned int [usertype] m_lkid
+fs/dlm/util.c:91:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:92:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:92:33:    expected unsigned int [usertype] m_remid
+fs/dlm/util.c:92:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:93:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:93:33:    expected unsigned int [usertype] m_parent_lkid
+fs/dlm/util.c:93:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:94:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:94:33:    expected unsigned int [usertype] m_parent_remid
+fs/dlm/util.c:94:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:95:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:95:33:    expected unsigned int [usertype] m_exflags
+fs/dlm/util.c:95:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:96:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:96:33:    expected unsigned int [usertype] m_sbflags
+fs/dlm/util.c:96:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:97:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:97:33:    expected unsigned int [usertype] m_flags
+fs/dlm/util.c:97:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:98:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:98:33:    expected unsigned int [usertype] m_lvbseq
+fs/dlm/util.c:98:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:99:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:99:33:    expected unsigned int [usertype] m_hash
+fs/dlm/util.c:99:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:100:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:100:33:    expected int m_status
+fs/dlm/util.c:100:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:101:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:101:33:    expected int m_grmode
+fs/dlm/util.c:101:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:102:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:102:33:    expected int m_rqmode
+fs/dlm/util.c:102:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:103:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:103:33:    expected int m_bastmode
+fs/dlm/util.c:103:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:104:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:104:33:    expected int m_asts
+fs/dlm/util.c:104:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:105:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:105:33:    expected int m_result
+fs/dlm/util.c:105:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:112:35: warning: cast to restricted __le32
+fs/dlm/util.c:113:35: warning: cast to restricted __le32
+fs/dlm/util.c:114:35: warning: cast to restricted __le32
+fs/dlm/util.c:115:35: warning: cast to restricted __le32
+fs/dlm/util.c:116:35: warning: cast to restricted __le32
+fs/dlm/util.c:117:35: warning: cast to restricted __le32
+fs/dlm/util.c:118:35: warning: cast to restricted __le32
+fs/dlm/util.c:119:35: warning: cast to restricted __le32
+fs/dlm/util.c:120:35: warning: cast to restricted __le32
+fs/dlm/util.c:121:35: warning: cast to restricted __le32
+fs/dlm/util.c:122:35: warning: cast to restricted __le32
+fs/dlm/util.c:123:35: warning: cast to restricted __le32
+fs/dlm/util.c:124:35: warning: cast to restricted __le32
+fs/dlm/util.c:125:35: warning: cast to restricted __le32
+fs/dlm/util.c:126:35: warning: cast to restricted __le32
+fs/dlm/util.c:127:35: warning: cast to restricted __le32
+fs/dlm/util.c:128:35: warning: cast to restricted __le32
+fs/dlm/util.c:129:50: warning: cast to restricted __le32
+fs/dlm/util.c:136:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:136:33:    expected unsigned int [usertype] rc_type
+fs/dlm/util.c:136:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:137:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:137:33:    expected int rc_result
+fs/dlm/util.c:137:33:    got restricted __le32 [usertype]
+fs/dlm/util.c:138:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:138:33:    expected unsigned long long [usertype] rc_id
+fs/dlm/util.c:138:33:    got restricted __le64 [usertype]
+fs/dlm/util.c:139:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:139:33:    expected unsigned long long [usertype] rc_seq
+fs/dlm/util.c:139:33:    got restricted __le64 [usertype]
+fs/dlm/util.c:140:33: warning: incorrect type in assignment (different base types)
+fs/dlm/util.c:140:33:    expected unsigned long long [usertype] rc_seq_reply
+fs/dlm/util.c:140:33:    got restricted __le64 [usertype]
+fs/dlm/util.c:147:35: warning: cast to restricted __le32
+fs/dlm/util.c:148:35: warning: cast to restricted __le32
+fs/dlm/util.c:149:35: warning: cast to restricted __le64
+fs/dlm/util.c:150:35: warning: cast to restricted __le64
+fs/dlm/util.c:151:35: warning: cast to restricted __le64
+  CC [M]  fs/dlm/util.o
+  CHECK   fs/dlm/debug_fs.c
+  CC [M]  fs/dlm/debug_fs.o
+  LD [M]  fs/dlm/dlm.o
+  CHECK   fs/ecryptfs/dentry.c
+  CC [M]  fs/ecryptfs/dentry.o
+  CHECK   fs/ecryptfs/file.c
+  CC [M]  fs/ecryptfs/file.o
+  CHECK   fs/ecryptfs/inode.c
+  CC [M]  fs/ecryptfs/inode.o
+  CHECK   fs/ecryptfs/main.c
+  CC [M]  fs/ecryptfs/main.o
+  CHECK   fs/ecryptfs/super.c
+  CC [M]  fs/ecryptfs/super.o
+  CHECK   fs/ecryptfs/mmap.c
+  CC [M]  fs/ecryptfs/mmap.o
+  CHECK   fs/ecryptfs/read_write.c
+  CC [M]  fs/ecryptfs/read_write.o
+  CHECK   fs/ecryptfs/crypto.c
+  CC [M]  fs/ecryptfs/crypto.o
+  CHECK   fs/ecryptfs/keystore.c
+  CC [M]  fs/ecryptfs/keystore.o
+  CHECK   fs/ecryptfs/kthread.c
+  CC [M]  fs/ecryptfs/kthread.o
+  CHECK   fs/ecryptfs/debug.c
+  CC [M]  fs/ecryptfs/debug.o
+  CHECK   fs/ecryptfs/messaging.c
+  CC [M]  fs/ecryptfs/messaging.o
+  CHECK   fs/ecryptfs/miscdev.c
+  CC [M]  fs/ecryptfs/miscdev.o
+  LD [M]  fs/ecryptfs/ecryptfs.o
+  CHECK   fs/efivarfs/inode.c
+  CC [M]  fs/efivarfs/inode.o
+  CHECK   fs/efivarfs/file.c
+  CC [M]  fs/efivarfs/file.o
+  CHECK   fs/efivarfs/super.c
+  CC [M]  fs/efivarfs/super.o
+  LD [M]  fs/efivarfs/efivarfs.o
+  CHECK   fs/efs/super.c
+  CC [M]  fs/efs/super.o
+  CHECK   fs/efs/inode.c
+  CC [M]  fs/efs/inode.o
+  CHECK   fs/efs/namei.c
+  CC [M]  fs/efs/namei.o
+  CHECK   fs/efs/dir.c
+  CC [M]  fs/efs/dir.o
+  CHECK   fs/efs/file.c
+  CC [M]  fs/efs/file.o
+  CHECK   fs/efs/symlink.c
+  CC [M]  fs/efs/symlink.o
+  LD [M]  fs/efs/efs.o
+  CHECK   fs/erofs/super.c
+  CC [M]  fs/erofs/super.o
+  CHECK   fs/erofs/inode.c
+  CC [M]  fs/erofs/inode.o
+  CHECK   fs/erofs/data.c
+  CC [M]  fs/erofs/data.o
+  CHECK   fs/erofs/namei.c
+  CC [M]  fs/erofs/namei.o
+  CHECK   fs/erofs/dir.c
+  CC [M]  fs/erofs/dir.o
+  CHECK   fs/erofs/utils.c
+  CC [M]  fs/erofs/utils.o
+  CHECK   fs/erofs/xattr.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/erofs/xattr.o
+  CHECK   fs/erofs/decompressor.c
+  CC [M]  fs/erofs/decompressor.o
+  CHECK   fs/erofs/zmap.c
+  CC [M]  fs/erofs/zmap.o
+  CHECK   fs/erofs/zdata.c
+  CC [M]  fs/erofs/zdata.o
+  LD [M]  fs/erofs/erofs.o
+  CHECK   fs/exportfs/expfs.c
+  CC      fs/exportfs/expfs.o
+  AR      fs/exportfs/built-in.a
+  CHECK   fs/ext2/balloc.c
+  CC [M]  fs/ext2/balloc.o
+  CHECK   fs/ext2/dir.c
+  CC [M]  fs/ext2/dir.o
+  CHECK   fs/ext2/file.c
+  CC [M]  fs/ext2/file.o
+  CHECK   fs/ext2/ialloc.c
+  CC [M]  fs/ext2/ialloc.o
+  CHECK   fs/ext2/inode.c
+  CC [M]  fs/ext2/inode.o
+  CHECK   fs/ext2/ioctl.c
+  CC [M]  fs/ext2/ioctl.o
+  CHECK   fs/ext2/namei.c
+  CC [M]  fs/ext2/namei.o
+  CHECK   fs/ext2/super.c
+  CC [M]  fs/ext2/super.o
+  CHECK   fs/ext2/symlink.c
+  CC [M]  fs/ext2/symlink.o
+  CHECK   fs/ext2/xattr.c
+  CC [M]  fs/ext2/xattr.o
+  CHECK   fs/ext2/xattr_user.c
+  CC [M]  fs/ext2/xattr_user.o
+  CHECK   fs/ext2/xattr_trusted.c
+  CC [M]  fs/ext2/xattr_trusted.o
+  CHECK   fs/ext2/acl.c
+  CC [M]  fs/ext2/acl.o
+  CHECK   fs/ext2/xattr_security.c
+  CC [M]  fs/ext2/xattr_security.o
+  LD [M]  fs/ext2/ext2.o
+  CHECK   fs/ext4/balloc.c
+  CC [M]  fs/ext4/balloc.o
+  CHECK   fs/ext4/bitmap.c
+  CC [M]  fs/ext4/bitmap.o
+  CHECK   fs/ext4/block_validity.c
+fs/ext4/block_validity.c:139:29: warning: incorrect type in argument 1 (different address spaces)
+fs/ext4/block_validity.c:139:29:    expected struct rb_root const *
+fs/ext4/block_validity.c:139:29:    got struct rb_root [noderef] <asn:4> *
+  CC [M]  fs/ext4/block_validity.o
+  CHECK   fs/ext4/dir.c
+  CC [M]  fs/ext4/dir.o
+  CHECK   fs/ext4/ext4_jbd2.c
+  CC [M]  fs/ext4/ext4_jbd2.o
+  CHECK   fs/ext4/extents.c
+  CC [M]  fs/ext4/extents.o
+  CHECK   fs/ext4/extents_status.c
+  CC [M]  fs/ext4/extents_status.o
+  CHECK   fs/ext4/file.c
+  CC [M]  fs/ext4/file.o
+  CHECK   fs/ext4/fsmap.c
+  CC [M]  fs/ext4/fsmap.o
+  CHECK   fs/ext4/fsync.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/ext4/fsync.o
+  CHECK   fs/ext4/hash.c
+  CC [M]  fs/ext4/hash.o
+  CHECK   fs/ext4/ialloc.c
+  CC [M]  fs/ext4/ialloc.o
+  CHECK   fs/ext4/indirect.c
+  CC [M]  fs/ext4/indirect.o
+  CHECK   fs/ext4/inline.c
+  CC [M]  fs/ext4/inline.o
+  CHECK   fs/ext4/inode.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/ext4/inode.o
+  CHECK   fs/ext4/ioctl.c
+  CC [M]  fs/ext4/ioctl.o
+  CHECK   fs/ext4/mballoc.c
+  CC [M]  fs/ext4/mballoc.o
+  CHECK   fs/ext4/migrate.c
+  CC [M]  fs/ext4/migrate.o
+  CHECK   fs/ext4/mmp.c
+  CC [M]  fs/ext4/mmp.o
+  CHECK   fs/ext4/move_extent.c
+  CC [M]  fs/ext4/move_extent.o
+  CHECK   fs/ext4/namei.c
+  CC [M]  fs/ext4/namei.o
+  CHECK   fs/ext4/page-io.c
+  CC [M]  fs/ext4/page-io.o
+  CHECK   fs/ext4/readpage.c
+  CC [M]  fs/ext4/readpage.o
+  CHECK   fs/ext4/resize.c
+  CC [M]  fs/ext4/resize.o
+  CHECK   fs/ext4/super.c
+  CC [M]  fs/ext4/super.o
+  CHECK   fs/ext4/symlink.c
+  CC [M]  fs/ext4/symlink.o
+  CHECK   fs/ext4/sysfs.c
+  CC [M]  fs/ext4/sysfs.o
+  CHECK   fs/ext4/xattr.c
+  CC [M]  fs/ext4/xattr.o
+  CHECK   fs/ext4/xattr_trusted.c
+  CC [M]  fs/ext4/xattr_trusted.o
+  CHECK   fs/ext4/xattr_user.c
+  CC [M]  fs/ext4/xattr_user.o
+  CHECK   fs/ext4/acl.c
+  CC [M]  fs/ext4/acl.o
+  CHECK   fs/ext4/xattr_security.c
+  CC [M]  fs/ext4/xattr_security.o
+  CHECK   fs/ext4/verity.c
+  CC [M]  fs/ext4/verity.o
+  LD [M]  fs/ext4/ext4.o
+  CHECK   fs/f2fs/dir.c
+fs/f2fs/dir.c:185:19: warning: incorrect type in assignment (different base types)
+fs/f2fs/dir.c:185:19:    expected unsigned int [assigned] [usertype] len
+fs/f2fs/dir.c:185:19:    got restricted __le16 [usertype] name_len
+  CC [M]  fs/f2fs/dir.o
+  CHECK   fs/f2fs/file.c
+fs/f2fs/file.c:43:54: warning: cast from restricted vm_fault_t
+fs/f2fs/file.c:3188:36: warning: incorrect type in argument 1 (different base types)
+fs/f2fs/file.c:3188:36:    expected unsigned short const [usertype] *pwcs
+fs/f2fs/file.c:3188:36:    got restricted __le16 *
+fs/f2fs/file.c:3224:28: warning: incorrect type in argument 4 (different base types)
+fs/f2fs/file.c:3224:28:    expected unsigned short [usertype] *pwcs
+fs/f2fs/file.c:3224:28:    got restricted __le16 *
+  CC [M]  fs/f2fs/file.o
+  CHECK   fs/f2fs/inode.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/f2fs/inode.o
+  CHECK   fs/f2fs/namei.c
+  CC [M]  fs/f2fs/namei.o
+  CHECK   fs/f2fs/hash.c
+fs/f2fs/hash.c:123:24: warning: incorrect type in return expression (different base types)
+fs/f2fs/hash.c:123:24:    expected restricted __le32
+fs/f2fs/hash.c:123:24:    got int
+fs/f2fs/hash.c:132:11: warning: incorrect type in assignment (different base types)
+fs/f2fs/hash.c:132:11:    expected int r
+fs/f2fs/hash.c:132:11:    got restricted __le32
+fs/f2fs/hash.c:135:16: warning: incorrect type in return expression (different base types)
+fs/f2fs/hash.c:135:16:    expected restricted __le32
+fs/f2fs/hash.c:135:16:    got int r
+  CC [M]  fs/f2fs/hash.o
+  CHECK   fs/f2fs/super.c
+fs/f2fs/super.c:939:35: warning: context imbalance in 'f2fs_drop_inode' - unexpected unlock
+  CC [M]  fs/f2fs/super.o
+  CHECK   fs/f2fs/inline.c
+  CC [M]  fs/f2fs/inline.o
+  CHECK   fs/f2fs/checkpoint.c
+  CC [M]  fs/f2fs/checkpoint.o
+  CHECK   fs/f2fs/gc.c
+  CC [M]  fs/f2fs/gc.o
+  CHECK   fs/f2fs/data.c
+  CC [M]  fs/f2fs/data.o
+  CHECK   fs/f2fs/node.c
+  CC [M]  fs/f2fs/node.o
+  CHECK   fs/f2fs/segment.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/f2fs/segment.o
+  CHECK   fs/f2fs/recovery.c
+  CC [M]  fs/f2fs/recovery.o
+  CHECK   fs/f2fs/shrinker.c
+  CC [M]  fs/f2fs/shrinker.o
+  CHECK   fs/f2fs/extent_cache.c
+fs/f2fs/extent_cache.c:676:38: warning: context imbalance in 'f2fs_shrink_extent_tree' - different lock contexts for basic block
+  CC [M]  fs/f2fs/extent_cache.o
+  CHECK   fs/f2fs/sysfs.c
+  CC [M]  fs/f2fs/sysfs.o
+  CHECK   fs/f2fs/debug.c
+  CC [M]  fs/f2fs/debug.o
+  CHECK   fs/f2fs/xattr.c
+  CC [M]  fs/f2fs/xattr.o
+  CHECK   fs/f2fs/acl.c
+  CC [M]  fs/f2fs/acl.o
+  CHECK   fs/f2fs/trace.c
+fs/f2fs/trace.c:142:9: warning: incorrect type in assignment (different address spaces)
+fs/f2fs/trace.c:142:9:    expected void **slot
+fs/f2fs/trace.c:142:9:    got void [noderef] <asn:4> **
+fs/f2fs/trace.c:142:9: warning: incorrect type in assignment (different address spaces)
+fs/f2fs/trace.c:142:9:    expected void **slot
+fs/f2fs/trace.c:142:9:    got void [noderef] <asn:4> **
+fs/f2fs/trace.c:142:9: warning: incorrect type in argument 1 (different address spaces)
+fs/f2fs/trace.c:142:9:    expected void [noderef] <asn:4> **slot
+fs/f2fs/trace.c:142:9:    got void **slot
+fs/f2fs/trace.c:142:9: warning: incorrect type in assignment (different address spaces)
+fs/f2fs/trace.c:142:9:    expected void **slot
+fs/f2fs/trace.c:142:9:    got void [noderef] <asn:4> **
+  CC [M]  fs/f2fs/trace.o
+  CHECK   fs/f2fs/verity.c
+  CC [M]  fs/f2fs/verity.o
+  LD [M]  fs/f2fs/f2fs.o
+  CHECK   fs/fat/cache.c
+  CC [M]  fs/fat/cache.o
+  CHECK   fs/fat/dir.c
+  CC [M]  fs/fat/dir.o
+  CHECK   fs/fat/fatent.c
+  CC [M]  fs/fat/fatent.o
+  CHECK   fs/fat/file.c
+  CC [M]  fs/fat/file.o
+  CHECK   fs/fat/inode.c
+  CC [M]  fs/fat/inode.o
+  CHECK   fs/fat/misc.c
+  CC [M]  fs/fat/misc.o
+  CHECK   fs/fat/nfs.c
+  CC [M]  fs/fat/nfs.o
+  LD [M]  fs/fat/fat.o
+  CHECK   fs/fat/namei_vfat.c
+  CC [M]  fs/fat/namei_vfat.o
+  LD [M]  fs/fat/vfat.o
+  CHECK   fs/fat/namei_msdos.c
+  CC [M]  fs/fat/namei_msdos.o
+  LD [M]  fs/fat/msdos.o
+  CHECK   fs/freevxfs/vxfs_bmap.c
+  CC [M]  fs/freevxfs/vxfs_bmap.o
+  CHECK   fs/freevxfs/vxfs_fshead.c
+  CC [M]  fs/freevxfs/vxfs_fshead.o
+  CHECK   fs/freevxfs/vxfs_immed.c
+  CC [M]  fs/freevxfs/vxfs_immed.o
+  CHECK   fs/freevxfs/vxfs_inode.c
+  CC [M]  fs/freevxfs/vxfs_inode.o
+  CHECK   fs/freevxfs/vxfs_lookup.c
+  CC [M]  fs/freevxfs/vxfs_lookup.o
+  CHECK   fs/freevxfs/vxfs_olt.c
+  CC [M]  fs/freevxfs/vxfs_olt.o
+  CHECK   fs/freevxfs/vxfs_subr.c
+  CC [M]  fs/freevxfs/vxfs_subr.o
+  CHECK   fs/freevxfs/vxfs_super.c
+  CC [M]  fs/freevxfs/vxfs_super.o
+  LD [M]  fs/freevxfs/freevxfs.o
+  CHECK   fs/fscache/cache.c
+  CC [M]  fs/fscache/cache.o
+  CHECK   fs/fscache/cookie.c
+  CC [M]  fs/fscache/cookie.o
+  CHECK   fs/fscache/fsdef.c
+  CC [M]  fs/fscache/fsdef.o
+  CHECK   fs/fscache/main.c
+  CC [M]  fs/fscache/main.o
+  CHECK   fs/fscache/netfs.c
+  CC [M]  fs/fscache/netfs.o
+  CHECK   fs/fscache/object.c
+  CC [M]  fs/fscache/object.o
+  CHECK   fs/fscache/operation.c
+  CC [M]  fs/fscache/operation.o
+  CHECK   fs/fscache/page.c
+  CC [M]  fs/fscache/page.o
+  CHECK   fs/fscache/proc.c
+  CC [M]  fs/fscache/proc.o
+  CHECK   fs/fscache/stats.c
+  CC [M]  fs/fscache/stats.o
+  CHECK   fs/fscache/histogram.c
+  CC [M]  fs/fscache/histogram.o
+  CHECK   fs/fscache/object-list.c
+  CC [M]  fs/fscache/object-list.o
+  LD [M]  fs/fscache/fscache.o
+  CHECK   fs/fuse/dev.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/fuse/dev.o
+  CHECK   fs/fuse/dir.c
+  CC [M]  fs/fuse/dir.o
+  CHECK   fs/fuse/file.c
+  CC [M]  fs/fuse/file.o
+  CHECK   fs/fuse/inode.c
+  CC [M]  fs/fuse/inode.o
+  CHECK   fs/fuse/control.c
+  CC [M]  fs/fuse/control.o
+  CHECK   fs/fuse/xattr.c
+  CC [M]  fs/fuse/xattr.o
+  CHECK   fs/fuse/acl.c
+  CC [M]  fs/fuse/acl.o
+  CHECK   fs/fuse/readdir.c
+  CC [M]  fs/fuse/readdir.o
+  LD [M]  fs/fuse/fuse.o
+  CHECK   fs/fuse/cuse.c
+  CC [M]  fs/fuse/cuse.o
+  CHECK   fs/fuse/virtio_fs.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/fuse/virtio_fs.o
+  LD [M]  fs/fuse/virtiofs.o
+  CHECK   fs/gfs2/acl.c
+  CC [M]  fs/gfs2/acl.o
+  CHECK   fs/gfs2/bmap.c
+  CC [M]  fs/gfs2/bmap.o
+  CHECK   fs/gfs2/dir.c
+  CC [M]  fs/gfs2/dir.o
+  CHECK   fs/gfs2/xattr.c
+  CC [M]  fs/gfs2/xattr.o
+  CHECK   fs/gfs2/glock.c
+fs/gfs2/glock.h:172:36: warning: context imbalance in '__gfs2_glock_put' - unexpected unlock
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+fs/gfs2/glock.c:697:13: warning: context imbalance in 'glock_work_func' - different lock contexts for basic block
+  CC [M]  fs/gfs2/glock.o
+  CHECK   fs/gfs2/glops.c
+  CC [M]  fs/gfs2/glops.o
+  CHECK   fs/gfs2/log.c
+  CC [M]  fs/gfs2/log.o
+  CHECK   fs/gfs2/lops.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/gfs2/lops.o
+  CHECK   fs/gfs2/main.c
+  CC [M]  fs/gfs2/main.o
+  CHECK   fs/gfs2/meta_io.c
+  CC [M]  fs/gfs2/meta_io.o
+  CHECK   fs/gfs2/aops.c
+  CC [M]  fs/gfs2/aops.o
+  CHECK   fs/gfs2/dentry.c
+  CC [M]  fs/gfs2/dentry.o
+  CHECK   fs/gfs2/export.c
+  CC [M]  fs/gfs2/export.o
+  CHECK   fs/gfs2/file.c
+  CC [M]  fs/gfs2/file.o
+  CHECK   fs/gfs2/ops_fstype.c
+fs/gfs2/ops_fstype.c:1331:39: warning: symbol 'gfs2_fs_parameters' was not declared. Should it be static?
+  CC [M]  fs/gfs2/ops_fstype.o
+  CHECK   fs/gfs2/inode.c
+  CC [M]  fs/gfs2/inode.o
+  CHECK   fs/gfs2/quota.c
+./include/linux/rculist_bl.h:24:33: error: incompatible types in comparison expression (different address spaces):
+./include/linux/rculist_bl.h:24:33:    struct hlist_bl_node [noderef] <asn:4> *
+./include/linux/rculist_bl.h:24:33:    struct hlist_bl_node *
+./include/linux/rculist_bl.h:17:9: error: incompatible types in comparison expression (different address spaces):
+./include/linux/rculist_bl.h:17:9:    struct hlist_bl_node [noderef] <asn:4> *
+./include/linux/rculist_bl.h:17:9:    struct hlist_bl_node *
+./include/linux/rculist_bl.h:17:9: error: incompatible types in comparison expression (different address spaces):
+./include/linux/rculist_bl.h:17:9:    struct hlist_bl_node [noderef] <asn:4> *
+./include/linux/rculist_bl.h:17:9:    struct hlist_bl_node *
+fs/gfs2/quota.c:312:9: warning: context imbalance in 'qd_put' - unexpected unlock
+  CC [M]  fs/gfs2/quota.o
+  CHECK   fs/gfs2/recovery.c
+  CC [M]  fs/gfs2/recovery.o
+  CHECK   fs/gfs2/rgrp.c
+  CC [M]  fs/gfs2/rgrp.o
+  CHECK   fs/gfs2/super.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/gfs2/super.o
+  CHECK   fs/gfs2/sys.c
+  CC [M]  fs/gfs2/sys.o
+  CHECK   fs/gfs2/trans.c
+  CC [M]  fs/gfs2/trans.o
+  CHECK   fs/gfs2/util.c
+  CC [M]  fs/gfs2/util.o
+  CHECK   fs/gfs2/lock_dlm.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/gfs2/lock_dlm.o
+  LD [M]  fs/gfs2/gfs2.o
+  CHECK   fs/hfs/bitmap.c
+  CC [M]  fs/hfs/bitmap.o
+  CHECK   fs/hfs/bfind.c
+  CC [M]  fs/hfs/bfind.o
+  CHECK   fs/hfs/bnode.c
+  CC [M]  fs/hfs/bnode.o
+  CHECK   fs/hfs/brec.c
+  CC [M]  fs/hfs/brec.o
+  CHECK   fs/hfs/btree.c
+  CC [M]  fs/hfs/btree.o
+  CHECK   fs/hfs/catalog.c
+  CC [M]  fs/hfs/catalog.o
+  CHECK   fs/hfs/dir.c
+  CC [M]  fs/hfs/dir.o
+  CHECK   fs/hfs/extent.c
+  CC [M]  fs/hfs/extent.o
+  CHECK   fs/hfs/inode.c
+  CC [M]  fs/hfs/inode.o
+  CHECK   fs/hfs/attr.c
+  CC [M]  fs/hfs/attr.o
+  CHECK   fs/hfs/mdb.c
+  CC [M]  fs/hfs/mdb.o
+  CHECK   fs/hfs/part_tbl.c
+  CC [M]  fs/hfs/part_tbl.o
+  CHECK   fs/hfs/string.c
+  CC [M]  fs/hfs/string.o
+  CHECK   fs/hfs/super.c
+fs/hfs/super.c:306:55: warning: incorrect type in argument 2 (different base types)
+fs/hfs/super.c:306:55:    expected unsigned int [usertype] *result
+fs/hfs/super.c:306:55:    got restricted __be32 *
+fs/hfs/super.c:312:55: warning: incorrect type in argument 2 (different base types)
+fs/hfs/super.c:312:55:    expected unsigned int [usertype] *result
+fs/hfs/super.c:312:55:    got restricted __be32 *
+  CC [M]  fs/hfs/super.o
+  CHECK   fs/hfs/sysdep.c
+  CC [M]  fs/hfs/sysdep.o
+  CHECK   fs/hfs/trans.c
+  CC [M]  fs/hfs/trans.o
+  LD [M]  fs/hfs/hfs.o
+  CHECK   fs/hfsplus/super.c
+  CC [M]  fs/hfsplus/super.o
+  CHECK   fs/hfsplus/options.c
+  CC [M]  fs/hfsplus/options.o
+  CHECK   fs/hfsplus/inode.c
+  CC [M]  fs/hfsplus/inode.o
+  CHECK   fs/hfsplus/ioctl.c
+fs/hfsplus/ioctl.c:42:50: warning: incorrect type in assignment (different base types)
+fs/hfsplus/ioctl.c:42:50:    expected unsigned int
+fs/hfsplus/ioctl.c:42:50:    got restricted __be32 [usertype]
+fs/hfsplus/ioctl.c:50:50: warning: incorrect type in assignment (different base types)
+fs/hfsplus/ioctl.c:50:50:    expected unsigned int
+fs/hfsplus/ioctl.c:50:50:    got restricted __be32 [usertype]
+fs/hfsplus/ioctl.c:53:50: warning: incorrect type in assignment (different base types)
+fs/hfsplus/ioctl.c:53:50:    expected unsigned int
+fs/hfsplus/ioctl.c:53:50:    got restricted __be32 [usertype]
+  CC [M]  fs/hfsplus/ioctl.o
+  CHECK   fs/hfsplus/extents.c
+  CC [M]  fs/hfsplus/extents.o
+  CHECK   fs/hfsplus/catalog.c
+  CC [M]  fs/hfsplus/catalog.o
+  CHECK   fs/hfsplus/dir.c
+  CC [M]  fs/hfsplus/dir.o
+  CHECK   fs/hfsplus/btree.c
+  CC [M]  fs/hfsplus/btree.o
+  CHECK   fs/hfsplus/bnode.c
+  CC [M]  fs/hfsplus/bnode.o
+  CHECK   fs/hfsplus/brec.c
+  CC [M]  fs/hfsplus/brec.o
+  CHECK   fs/hfsplus/bfind.c
+  CC [M]  fs/hfsplus/bfind.o
+  CHECK   fs/hfsplus/tables.c
+  CC [M]  fs/hfsplus/tables.o
+  CHECK   fs/hfsplus/unicode.c
+  CC [M]  fs/hfsplus/unicode.o
+  CHECK   fs/hfsplus/wrapper.c
+  CC [M]  fs/hfsplus/wrapper.o
+  CHECK   fs/hfsplus/bitmap.c
+  CC [M]  fs/hfsplus/bitmap.o
+  CHECK   fs/hfsplus/part_tbl.c
+  CC [M]  fs/hfsplus/part_tbl.o
+  CHECK   fs/hfsplus/attributes.c
+  CC [M]  fs/hfsplus/attributes.o
+  CHECK   fs/hfsplus/xattr.c
+  CC [M]  fs/hfsplus/xattr.o
+  CHECK   fs/hfsplus/xattr_user.c
+  CC [M]  fs/hfsplus/xattr_user.o
+  CHECK   fs/hfsplus/xattr_security.c
+  CC [M]  fs/hfsplus/xattr_security.o
+  CHECK   fs/hfsplus/xattr_trusted.c
+  CC [M]  fs/hfsplus/xattr_trusted.o
+  LD [M]  fs/hfsplus/hfsplus.o
+  CHECK   fs/hpfs/alloc.c
+  CC [M]  fs/hpfs/alloc.o
+  CHECK   fs/hpfs/anode.c
+  CC [M]  fs/hpfs/anode.o
+  CHECK   fs/hpfs/buffer.c
+  CC [M]  fs/hpfs/buffer.o
+  CHECK   fs/hpfs/dentry.c
+  CC [M]  fs/hpfs/dentry.o
+  CHECK   fs/hpfs/dir.c
+  CC [M]  fs/hpfs/dir.o
+  CHECK   fs/hpfs/dnode.c
+  CC [M]  fs/hpfs/dnode.o
+  CHECK   fs/hpfs/ea.c
+  CC [M]  fs/hpfs/ea.o
+  CHECK   fs/hpfs/file.c
+  CC [M]  fs/hpfs/file.o
+  CHECK   fs/hpfs/inode.c
+  CC [M]  fs/hpfs/inode.o
+  CHECK   fs/hpfs/map.c
+  CC [M]  fs/hpfs/map.o
+  CHECK   fs/hpfs/name.c
+  CC [M]  fs/hpfs/name.o
+  CHECK   fs/hpfs/namei.c
+  CC [M]  fs/hpfs/namei.o
+  CHECK   fs/hpfs/super.c
+  CC [M]  fs/hpfs/super.o
+  LD [M]  fs/hpfs/hpfs.o
+  CHECK   fs/hugetlbfs/inode.c
+  CC      fs/hugetlbfs/inode.o
+  AR      fs/hugetlbfs/built-in.a
+  CHECK   fs/iomap/apply.c
+  CC      fs/iomap/apply.o
+  CHECK   fs/iomap/buffered-io.c
+  CC      fs/iomap/buffered-io.o
+  CHECK   fs/iomap/direct-io.c
+  CC      fs/iomap/direct-io.o
+  CHECK   fs/iomap/fiemap.c
+  CC      fs/iomap/fiemap.o
+  CHECK   fs/iomap/seek.c
+  CC      fs/iomap/seek.o
+  CHECK   fs/iomap/swapfile.c
+  CC      fs/iomap/swapfile.o
+  AR      fs/iomap/built-in.a
+  CHECK   fs/isofs/namei.c
+  CC [M]  fs/isofs/namei.o
+  CHECK   fs/isofs/inode.c
+  CC [M]  fs/isofs/inode.o
+  CHECK   fs/isofs/dir.c
+  CC [M]  fs/isofs/dir.o
+  CHECK   fs/isofs/util.c
+  CC [M]  fs/isofs/util.o
+  CHECK   fs/isofs/rock.c
+  CC [M]  fs/isofs/rock.o
+  CHECK   fs/isofs/export.c
+  CC [M]  fs/isofs/export.o
+  CHECK   fs/isofs/joliet.c
+  CC [M]  fs/isofs/joliet.o
+  CHECK   fs/isofs/compress.c
+  CC [M]  fs/isofs/compress.o
+  LD [M]  fs/isofs/isofs.o
+  CHECK   fs/jbd2/transaction.c
+fs/jbd2/transaction.c:168:13: warning: context imbalance in 'wait_transaction_switching' - wrong count at exit
+fs/jbd2/transaction.c:213:17: warning: context imbalance in 'add_transaction_credits' - unexpected unlock
+fs/jbd2/transaction.c:345:9: warning: context imbalance in 'start_this_handle' - different lock contexts for basic block
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/jbd2/transaction.o
+  CHECK   fs/jbd2/commit.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/jbd2/commit.o
+  CHECK   fs/jbd2/recovery.c
+  CC [M]  fs/jbd2/recovery.o
+  CHECK   fs/jbd2/checkpoint.c
+fs/jbd2/checkpoint.c:142:36: warning: context imbalance in '__jbd2_log_wait_for_space' - unexpected unlock
+  CC [M]  fs/jbd2/checkpoint.o
+  CHECK   fs/jbd2/revoke.c
+  CC [M]  fs/jbd2/revoke.o
+  CHECK   fs/jbd2/journal.c
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/jbd2/journal.o
+  LD [M]  fs/jbd2/jbd2.o
+  CHECK   fs/jffs2/compr.c
+  CC [M]  fs/jffs2/compr.o
+  CHECK   fs/jffs2/dir.c
+  CC [M]  fs/jffs2/dir.o
+  CHECK   fs/jffs2/file.c
+  CC [M]  fs/jffs2/file.o
+  CHECK   fs/jffs2/ioctl.c
+  CC [M]  fs/jffs2/ioctl.o
+  CHECK   fs/jffs2/nodelist.c
+  CC [M]  fs/jffs2/nodelist.o
+  CHECK   fs/jffs2/malloc.c
+  CC [M]  fs/jffs2/malloc.o
+  CHECK   fs/jffs2/read.c
+  CC [M]  fs/jffs2/read.o
+  CHECK   fs/jffs2/nodemgmt.c
+  CC [M]  fs/jffs2/nodemgmt.o
+  CHECK   fs/jffs2/readinode.c
+  CC [M]  fs/jffs2/readinode.o
+  CHECK   fs/jffs2/write.c
+  CC [M]  fs/jffs2/write.o
+  CHECK   fs/jffs2/scan.c
+  CC [M]  fs/jffs2/scan.o
+  CHECK   fs/jffs2/gc.c
+fs/jffs2/gc.c:219:25: warning: context imbalance in 'jffs2_garbage_collect_pass' - unexpected unlock
+  CC [M]  fs/jffs2/gc.o
+  CHECK   fs/jffs2/symlink.c
+  CC [M]  fs/jffs2/symlink.o
+  CHECK   fs/jffs2/build.c
+  CC [M]  fs/jffs2/build.o
+  CHECK   fs/jffs2/erase.c
+fs/jffs2/erase.c:110:27: warning: context imbalance in 'jffs2_erase_pending_blocks' - different lock contexts for basic block
+  CC [M]  fs/jffs2/erase.o
+  CHECK   fs/jffs2/background.c
+  CC [M]  fs/jffs2/background.o
+  CHECK   fs/jffs2/fs.c
+  CC [M]  fs/jffs2/fs.o
+  CHECK   fs/jffs2/writev.c
+  CC [M]  fs/jffs2/writev.o
+  CHECK   fs/jffs2/super.c
+fs/jffs2/super.c:364:1: error: directive in macro's argument list
+fs/jffs2/super.c:366:1: error: directive in macro's argument list
+fs/jffs2/super.c:367:1: error: directive in macro's argument list
+fs/jffs2/super.c:369:1: error: directive in macro's argument list
+  CC [M]  fs/jffs2/super.o
+  CHECK   fs/jffs2/debug.c
+  CC [M]  fs/jffs2/debug.o
+  CHECK   fs/jffs2/wbuf.c
+  CC [M]  fs/jffs2/wbuf.o
+  CHECK   fs/jffs2/xattr.c
+  CC [M]  fs/jffs2/xattr.o
+  CHECK   fs/jffs2/xattr_trusted.c
+  CC [M]  fs/jffs2/xattr_trusted.o
+  CHECK   fs/jffs2/xattr_user.c
+  CC [M]  fs/jffs2/xattr_user.o
+  CHECK   fs/jffs2/security.c
+  CC [M]  fs/jffs2/security.o
+  CHECK   fs/jffs2/acl.c
+  CC [M]  fs/jffs2/acl.o
+  CHECK   fs/jffs2/compr_rubin.c
+  CC [M]  fs/jffs2/compr_rubin.o
+  CHECK   fs/jffs2/compr_rtime.c
+  CC [M]  fs/jffs2/compr_rtime.o
+  CHECK   fs/jffs2/compr_zlib.c
+  CC [M]  fs/jffs2/compr_zlib.o
+  CHECK   fs/jffs2/compr_lzo.c
+  CC [M]  fs/jffs2/compr_lzo.o
+  CHECK   fs/jffs2/summary.c
+  CC [M]  fs/jffs2/summary.o
+  LD [M]  fs/jffs2/jffs2.o
+  CHECK   fs/jfs/super.c
+  CC [M]  fs/jfs/super.o
+  CHECK   fs/jfs/file.c
+  CC [M]  fs/jfs/file.o
+  CHECK   fs/jfs/inode.c
+  CC [M]  fs/jfs/inode.o
+  CHECK   fs/jfs/namei.c
+  CC [M]  fs/jfs/namei.o
+  CHECK   fs/jfs/jfs_mount.c
+  CC [M]  fs/jfs/jfs_mount.o
+  CHECK   fs/jfs/jfs_umount.c
+  CC [M]  fs/jfs/jfs_umount.o
+  CHECK   fs/jfs/jfs_xtree.c
+  CC [M]  fs/jfs/jfs_xtree.o
+  CHECK   fs/jfs/jfs_imap.c
+  CC [M]  fs/jfs/jfs_imap.o
+  CHECK   fs/jfs/jfs_debug.c
+  CC [M]  fs/jfs/jfs_debug.o
+  CHECK   fs/jfs/jfs_dmap.c
+  CC [M]  fs/jfs/jfs_dmap.o
+  CHECK   fs/jfs/jfs_unicode.c
+  CC [M]  fs/jfs/jfs_unicode.o
+  CHECK   fs/jfs/jfs_dtree.c
+  CC [M]  fs/jfs/jfs_dtree.o
+  CHECK   fs/jfs/jfs_inode.c
+  CC [M]  fs/jfs/jfs_inode.o
+  CHECK   fs/jfs/jfs_discard.c
+  CC [M]  fs/jfs/jfs_discard.o
+  CHECK   fs/jfs/jfs_extent.c
+  CC [M]  fs/jfs/jfs_extent.o
+  CHECK   fs/jfs/symlink.c
+  CC [M]  fs/jfs/symlink.o
+  CHECK   fs/jfs/jfs_metapage.c
+  CC [M]  fs/jfs/jfs_metapage.o
+  CHECK   fs/jfs/jfs_logmgr.c
+  CC [M]  fs/jfs/jfs_logmgr.o
+  CHECK   fs/jfs/jfs_txnmgr.c
+  CC [M]  fs/jfs/jfs_txnmgr.o
+  CHECK   fs/jfs/jfs_uniupr.c
+  CC [M]  fs/jfs/jfs_uniupr.o
+  CHECK   fs/jfs/resize.c
+  CC [M]  fs/jfs/resize.o
+  CHECK   fs/jfs/xattr.c
+  CC [M]  fs/jfs/xattr.o
+  CHECK   fs/jfs/ioctl.c
+  CC [M]  fs/jfs/ioctl.o
+  CHECK   fs/jfs/acl.c
+  CC [M]  fs/jfs/acl.o
+  LD [M]  fs/jfs/jfs.o
+  CHECK   fs/kernfs/mount.c
+  CC      fs/kernfs/mount.o
+  CHECK   fs/kernfs/inode.c
+  CC      fs/kernfs/inode.o
+  CHECK   fs/kernfs/dir.c
+  CC      fs/kernfs/dir.o
+  CHECK   fs/kernfs/file.c
+  CC      fs/kernfs/file.o
+  CHECK   fs/kernfs/symlink.c
+  CC      fs/kernfs/symlink.o
+  AR      fs/kernfs/built-in.a
+  CHECK   fs/lockd/clntlock.c
+  CC [M]  fs/lockd/clntlock.o
+  CHECK   fs/lockd/clntproc.c
+./include/linux/list.h:139:25: warning: context imbalance in 'nlmclnt_put_lockowner' - unexpected unlock
+  CC [M]  fs/lockd/clntproc.o
+  CHECK   fs/lockd/clntxdr.c
+  CC [M]  fs/lockd/clntxdr.o
+  CHECK   fs/lockd/host.c
+  CC [M]  fs/lockd/host.o
+  CHECK   fs/lockd/svc.c
+  CC [M]  fs/lockd/svc.o
+  CHECK   fs/lockd/svclock.c
+./include/linux/list.h:139:25: warning: context imbalance in 'nlmsvc_put_lockowner' - unexpected unlock
+  CC [M]  fs/lockd/svclock.o
+  CHECK   fs/lockd/svcshare.c
+  CC [M]  fs/lockd/svcshare.o
+  CHECK   fs/lockd/svcproc.c
+  CC [M]  fs/lockd/svcproc.o
+  CHECK   fs/lockd/svcsubs.c
+  CC [M]  fs/lockd/svcsubs.o
+  CHECK   fs/lockd/mon.c
+./include/linux/list.h:139:25: warning: context imbalance in 'nsm_release' - unexpected unlock
+  CC [M]  fs/lockd/mon.o
+  CHECK   fs/lockd/xdr.c
+  CC [M]  fs/lockd/xdr.o
+  CHECK   fs/lockd/clnt4xdr.c
+  CC [M]  fs/lockd/clnt4xdr.o
+  CHECK   fs/lockd/xdr4.c
+  CC [M]  fs/lockd/xdr4.o
+  CHECK   fs/lockd/svc4proc.c
+  CC [M]  fs/lockd/svc4proc.o
+  CHECK   fs/lockd/procfs.c
+  CC [M]  fs/lockd/procfs.o
+  LD [M]  fs/lockd/lockd.o
+  CHECK   fs/minix/bitmap.c
+  CC [M]  fs/minix/bitmap.o
+  CHECK   fs/minix/itree_v1.c
+  CC [M]  fs/minix/itree_v1.o
+  CHECK   fs/minix/itree_v2.c
+  CC [M]  fs/minix/itree_v2.o
+  CHECK   fs/minix/namei.c
+  CC [M]  fs/minix/namei.o
+  CHECK   fs/minix/inode.c
+  CC [M]  fs/minix/inode.o
+  CHECK   fs/minix/file.c
+  CC [M]  fs/minix/file.o
+  CHECK   fs/minix/dir.c
+  CC [M]  fs/minix/dir.o
+  LD [M]  fs/minix/minix.o
+  CHECK   fs/nfs/client.c
+./include/linux/list.h:139:25: warning: context imbalance in 'nfs_put_client' - unexpected unlock
+  CC [M]  fs/nfs/client.o
+  CHECK   fs/nfs/dir.c
+  CC [M]  fs/nfs/dir.o
+  CHECK   fs/nfs/file.c
+  CC [M]  fs/nfs/file.o
+  CHECK   fs/nfs/getroot.c
+  CC [M]  fs/nfs/getroot.o
+  CHECK   fs/nfs/inode.c
+./include/linux/rculist.h:148:25: warning: context imbalance in 'nfs_put_lock_context' - unexpected unlock
+  CC [M]  fs/nfs/inode.o
+  CHECK   fs/nfs/super.c
+fs/nfs/super.c:2948:14: warning: symbol 'nfs_idmap_cache_timeout' was not declared. Should it be static?
+  CC [M]  fs/nfs/super.o
+  CHECK   fs/nfs/io.c
+  CC [M]  fs/nfs/io.o
+  CHECK   fs/nfs/direct.c
+  CC [M]  fs/nfs/direct.o
+  CHECK   fs/nfs/pagelist.c
+  CC [M]  fs/nfs/pagelist.o
+  CHECK   fs/nfs/read.c
+  CC [M]  fs/nfs/read.o
+  CHECK   fs/nfs/symlink.c
+  CC [M]  fs/nfs/symlink.o
+  CHECK   fs/nfs/unlink.c
+  CC [M]  fs/nfs/unlink.o
+  CHECK   fs/nfs/write.c
+  CC [M]  fs/nfs/write.o
+  CHECK   fs/nfs/namespace.c
+  CC [M]  fs/nfs/namespace.o
+  CHECK   fs/nfs/mount_clnt.c
+  CC [M]  fs/nfs/mount_clnt.o
+  CHECK   fs/nfs/nfstrace.c
+fs/nfs/./nfstrace.h:365:1: warning: incorrect type in initializer (different base types)
+fs/nfs/./nfstrace.h:365:1:    expected unsigned long eval_value
+fs/nfs/./nfstrace.h:365:1:    got restricted fmode_t [usertype]
+fs/nfs/./nfstrace.h:366:1: warning: incorrect type in initializer (different base types)
+fs/nfs/./nfstrace.h:366:1:    expected unsigned long eval_value
+fs/nfs/./nfstrace.h:366:1:    got restricted fmode_t [usertype]
+fs/nfs/./nfstrace.h:367:1: warning: incorrect type in initializer (different base types)
+fs/nfs/./nfstrace.h:367:1:    expected unsigned long eval_value
+fs/nfs/./nfstrace.h:367:1:    got restricted fmode_t [usertype]
+  CC [M]  fs/nfs/nfstrace.o
+  CHECK   fs/nfs/export.c
+  CC [M]  fs/nfs/export.o
+  CHECK   fs/nfs/sysfs.c
+  CC [M]  fs/nfs/sysfs.o
+  CHECK   fs/nfs/sysctl.c
+  CC [M]  fs/nfs/sysctl.o
+  CHECK   fs/nfs/fscache.c
+  CC [M]  fs/nfs/fscache.o
+  CHECK   fs/nfs/fscache-index.c
+  CC [M]  fs/nfs/fscache-index.o
+  LD [M]  fs/nfs/nfs.o
+  CHECK   fs/nfs/nfs2super.c
+  CC [M]  fs/nfs/nfs2super.o
+  CHECK   fs/nfs/proc.c
+  CC [M]  fs/nfs/proc.o
+  CHECK   fs/nfs/nfs2xdr.c
+  CC [M]  fs/nfs/nfs2xdr.o
+  LD [M]  fs/nfs/nfsv2.o
+  CHECK   fs/nfs/nfs3super.c
+  CC [M]  fs/nfs/nfs3super.o
+  CHECK   fs/nfs/nfs3client.c
+  CC [M]  fs/nfs/nfs3client.o
+  CHECK   fs/nfs/nfs3proc.c
+  CC [M]  fs/nfs/nfs3proc.o
+  CHECK   fs/nfs/nfs3xdr.c
+  CC [M]  fs/nfs/nfs3xdr.o
+  CHECK   fs/nfs/nfs3acl.c
+  CC [M]  fs/nfs/nfs3acl.o
+  LD [M]  fs/nfs/nfsv3.o
+  CHECK   fs/nfs/nfs4proc.c
+  CC [M]  fs/nfs/nfs4proc.o
+  CHECK   fs/nfs/nfs4xdr.c
+  CC [M]  fs/nfs/nfs4xdr.o
+  CHECK   fs/nfs/nfs4state.c
+fs/nfs/nfs4state.c:80:20: warning: symbol 'current_stateid' was not declared. Should it be static?
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./include/linux/list.h:139:25: warning: context imbalance in 'nfs4_put_open_state' - unexpected unlock
+fs/nfs/nfs4state.c:945:20: warning: context imbalance in 'nfs4_put_lock_state' - unexpected unlock
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/nfs/nfs4state.o
+  CHECK   fs/nfs/nfs4renewd.c
+  CC [M]  fs/nfs/nfs4renewd.o
+  CHECK   fs/nfs/nfs4super.c
+  CC [M]  fs/nfs/nfs4super.o
+  CHECK   fs/nfs/nfs4file.c
+  CC [M]  fs/nfs/nfs4file.o
+  CHECK   fs/nfs/delegation.c
+  CC [M]  fs/nfs/delegation.o
+  CHECK   fs/nfs/nfs4idmap.c
+  CC [M]  fs/nfs/nfs4idmap.o
+  CHECK   fs/nfs/callback.c
+  CC [M]  fs/nfs/callback.o
+  CHECK   fs/nfs/callback_xdr.c
+  CC [M]  fs/nfs/callback_xdr.o
+  CHECK   fs/nfs/callback_proc.c
+  CC [M]  fs/nfs/callback_proc.o
+  CHECK   fs/nfs/nfs4namespace.c
+  CC [M]  fs/nfs/nfs4namespace.o
+  CHECK   fs/nfs/nfs4getroot.c
+  CC [M]  fs/nfs/nfs4getroot.o
+  CHECK   fs/nfs/nfs4client.c
+  CC [M]  fs/nfs/nfs4client.o
+  CHECK   fs/nfs/nfs4session.c
+  CC [M]  fs/nfs/nfs4session.o
+  CHECK   fs/nfs/dns_resolve.c
+  CC [M]  fs/nfs/dns_resolve.o
+  CHECK   fs/nfs/nfs4trace.c
+  CC [M]  fs/nfs/nfs4trace.o
+  CHECK   fs/nfs/cache_lib.c
+  CC [M]  fs/nfs/cache_lib.o
+  CHECK   fs/nfs/nfs4sysctl.c
+  CC [M]  fs/nfs/nfs4sysctl.o
+  CHECK   fs/nfs/pnfs.c
+fs/nfs/pnfs.c:306:17: warning: context imbalance in 'pnfs_put_layout_hdr' - unexpected unlock
+fs/nfs/pnfs.c:564:36: warning: context imbalance in 'pnfs_put_lseg' - unexpected unlock
+./arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
+  CC [M]  fs/nfs/pnfs.o
+  CHECK   fs/nfs/pnfs_dev.c
+  CC [M]  fs/nfs/pnfs_dev.o
+  CHECK   fs/nfs/pnfs_nfs.c
+./include/linux/list.h:190:25: warning: context imbalance in 'nfs4_pnfs_ds_put' - unexpected unlock
+  CC [M]  fs/nfs/pnfs_nfs.o
+  CHECK   fs/nfs/nfs42proc.c
+  CC [M]  fs/nfs/nfs42proc.o
+  LD [M]  fs/nfs/nfsv4.o
+  CHECK   fs/nfs/blocklayout/blocklayout.c
+  CC [M]  fs/nfs/blocklayout/blocklayout.o
+  CHECK   fs/nfs/blocklayout/dev.c
+  CC [M]  fs/nfs/blocklayout/dev.o
+  CHECK   fs/nfs/blocklayout/extent_tree.c
+  CC [M]  fs/nfs/blocklayout/extent_tree.o
+  CHECK   fs/nfs/blocklayout/rpc_pipefs.c
+  CC [M]  fs/nfs/blocklayout/rpc_pipefs.o
+  LD [M]  fs/nfs/blocklayout/blocklayoutdriver.o
+  CHECK   fs/nfs/filelayout/filelayout.c
+  CC [M]  fs/nfs/filelayout/filelayout.o
+  CHECK   fs/nfs/filelayout/filelayoutdev.c
+  CC [M]  fs/nfs/filelayout/filelayoutdev.o
+  LD [M]  fs/nfs/filelayout/nfs_layout_nfsv41_files.o
+  CHECK   fs/nfs/flexfilelayout/flexfilelayout.c
+  CC [M]  fs/nfs/flexfilelayout/flexfilelayout.o
+  CHECK   fs/nfs/flexfilelayout/flexfilelayoutdev.c
+  CC [M]  fs/nfs/flexfilelayout/flexfilelayoutdev.o
+  LD [M]  fs/nfs/flexfilelayout/nfs_layout_flexfiles.o
+  CHECK   fs/nfs_common/nfsacl.c
+  CC [M]  fs/nfs_common/nfsacl.o
+  LD [M]  fs/nfs_common/nfs_acl.o
+  CHECK   fs/nfs_common/grace.c
+  CC [M]  fs/nfs_common/grace.o
+make[2]: *** Deleting file 'fs/nfs_common/grace.o'
+scripts/Makefile.build:265: recipe for target 'fs/nfs_common/grace.o' failed
+make[2]: *** [fs/nfs_common/grace.o] Interrupt
+scripts/Makefile.build:509: recipe for target 'fs/nfs_common' failed
+make[1]: *** [fs/nfs_common] Interrupt
+Makefile:1652: recipe for target 'fs' failed
+make: *** [fs] Interrupt
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e180033e35cf..172d92da3c83 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2350,7 +2350,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	rcu_read_lock();
 	if (nfsi->cache_validity & NFS_INO_INVALID_ACCESS)
 		goto out;
-	lh = rcu_dereference(nfsi->access_cache_entry_lru.prev);
+	lh = rcu_dereference(*(struct list_head __rcu **)nfsi->access_cache_entry_lru.prev);
 	cache = list_entry(lh, struct nfs_access_entry, lru);
 	if (lh == &nfsi->access_cache_entry_lru ||
 	    cred != cache->cred)
diff --git a/scripts/pnmtologo b/scripts/pnmtologo
new file mode 100755
index 0000000000000000000000000000000000000000..77946c9d96fcd061b42623c3e314c2e4ebc06f3d
GIT binary patch
literal 18112
zcmeHPeRNaDl^;nK7=!&Bf>S~uJiw%e#>VDrZH$R!WOzyhxM1fy2qDY1Qd@GRr(lwH
zODda1QPg<bY)ijs+GbPQ?9$ULNpqUSd<2JVHzo8V>5{ahO&U242_Y2RG(r2j^Je5H
zVYlb>?4OL!)1CX9d+*$txijy*dGGmijqWv8i-pN#W2+c(>NEqX7X|g#i3~_Rt7en%
zdo`QICV<c5m{DGD5R@8eM3|N|U*I-S(yO)_KrWpr<Rq0I619u6u}EsJfl7*&aDep4
z*UECvf~q_t>1p9dJqhuo@?U}p>JWMzLQm4u!ZAr@`>1VnGz+`A)QK`ml9DW?rZ@Cf
z%J-|pT}(R-m`N)2J_)^y>q6#lkz!G}QPekHzZ?_(ODdYn7Ig-;E?>H+v$ec45RCSe
z_f#)0U%s>=5~^6t+fDXKcJ2BWUK5SCFvZI$ya=Q68%opDKKmWkx8coiynlIO_v~L>
zf6F#1yBvocH)|hqmYG(<NcRdH3ufIvbKocEr`DWF%v^l<{M4U3bbcz}G1I+3$10pR
z4*nK!6-RDr0x*`HS>xdQ$H5;S2cLjuswm4%Hvt%{Uh3zu@TKG6lgGjD9tW=-2QL}N
z&qv3R?*~2?M{e2-U@ZS#z%OH0GPP3WDso<ZTj2Eqm+>DF_?8@biW9O^mLpH|hw#cA
zd4{<5Q5Y|0{+@u&+Cts_APaTtfnY0ZYxnCu=JEK$;b6$q8S;7cKq$z7LI8MMcQ_E#
z+dRIGPqB#J8j3>S*BOfVS(mpH;t=ua+q?aqt)xs=z2SC}ghAG}EgaDO5V^~21{ytH
zPg@}9?F`)QCl!*7=wV-1HxY25FqFt`PXzXKPnS0kWNY27hSi?M6-zR?#TCmk`6U%g
zna9<<&V!o$?STl4Hm_UV84CKFy<0oUiT18gP}uVrqGJl87p;6A+we<&G^^zw&3DS@
zWe^+YGaZak+)}zc5GbUT@;T%Qi_Qp4BCX?s*RLer%6<o)l3cH4Jg^c2uNLdF#0SLr
zOUuE}&Nk$ma_~IWz;DjMO9Z|p2QL$Neop*IetHgGE975ZWMpWqrrwh2qzN~#<0%s^
z+eSL4O}HYBfR32(%S^bOM|AF_HB=@!F9@f(B9ojKgnvwepmN?3F1nbP%6Uh)7!r<m
z3x6hpqj8t1$AruC0+sDB;c{*hzRQGD9WwQsaH>P5-6k9Xlu3I`ctHkb>=6@AYotv3
zO!yQDf<9rw5x|)=V8V+sC}Yo=a2fkle9VNK*Fi1zcD|OdH(sMMt#3fLrjKc{!}*6;
zdfDFjDofA*5q_1~^~e$5L8gXIrjh19L_Br%&@s+`jd<$fp#jc+k$4Kdp?#dckN7;|
z_i+C6#8Vd!^>hAi;wdDDc5psSJazR@H|Ospo<ehI3+J~IPhCFL#Q9r^r>-8V=ln+E
zsf&jyIe$Iz)U`uuM!$_t7d$y`a@^=>aVN`ZLOYsW@v|+P;(tZ&OxF@u4BEFtnUWSS
z`5LCAJN}kC{-^lwQ!OwR8%Zm@51}wN64I5}h^{Y;jRf_Q)XVS&eOm=xEpFckz2PI^
z=NP;dWO%=pD8G#O<gyK@Sc|`#I({LY?i+|s8MObZROPWe+>hdAqWCAgSic5PnSl0i
zNa-8EXbjrF1ufp~H^H|-`vYM4sAyo5tJAgiuL4o}HiOl6!^#;<Q&(c;VJ%+w_{UY2
z3d5Qfe-_c8^sYdEYw^KU1+dsilhQYh1MjA00dT|*$3~VY5A1{a*hr=Fh4UCKY5}8m
z$KQ?HH<7(F7$Zmg*|^;S&UN4on;Rk@eMFVmuK}dR5AnKwJ^_AMo*h;bbypD_JCv^_
zSAH&aoQtj=;X?mTLN%{OPdH*9E>?P1p`pkvQTl!ZC#ddT)HdiW<x|KJKN3IWc=4SC
z_*(lxgt!trh;f29ja9FcE5qAKrwKY*qU5U(aK>K)5*SEB%$;26a>Nc>u1_poSasZK
zIeq^9hFy89QgaOPJ0YHt&607hvZOwwj!Kl!yfUoiNLZb<^OurGpTC<z2p(F7nrTRq
z%WlE^B)5)!NP(dAJ%$b#v=7czar#2^?%@6LZt6Z1C+v>_j*Zxq-tV9Tlm`ZR7+RFx
zJJB<-5v$U-A3@<vEPD<?=1i171yXg&ot*U{Dsd<3z7M`J*_L*pog0#+t&W;g%FczT
zr?KyxuDcS`-gPBsPE%$xr?P)4j_WN|>8f+cG+4Ey{XQ6}IyyWR<;wniWq-Ftiw)S6
z{XJ<%^?UWogGU_I&npiesPBD2w>zpw^ck+2L(yMr$+`<Tl~fI+&SNx{**oAfhWnsR
ztNCU0D_ZPX%TSd1WF$}N8$ppXQ8<BnZ?}>6N3}%VI|yM%%~56N3OfuPchnqHc3y+5
zmdx9z+46n?YZhgHWqozGH97&m7X1~}x(O#L)Os&!b;RCYiomfd|I$EeiDf^7MTq<x
z)>4RUhKQCZ{0hJ)QI0NqnpQdpEXJa$C1?H597J}{Uol>Z!W!gxan%4^^KnBZZ^KZk
z9Rh>)&!U{t@Em1-En0`jwxzx?5l!EJ&xO>Nj7&OpA2PM&x6e^o_@z`5F;<mMP2dLV
zfl>7cT13qU^AI($4-f^;_#YdqPH6}JXd7NY0kg~S`b7vh<8L`oRV-!ElGD&7)2`gr
zVBOVV*@d_({}}|rFHmR?|0nbstInm?QJ-LvV!E7i)-L-puj9+8qcMKAu`2C4@Vaey
z3Dr@`>nQ2sb^OH<8?+eVttF?puD4B@OA{q^{{3AJ>n?|7m&I9Ix1MS{?1&w)41XUj
z(30i-DjckxU&Sk#jg}=!79ihuT<P75W}-`rxcQUGThr()i#sv%fR>zjo7-}tO_|*b
z5vUX{hLygf`i4ej|K&JtKuhh*fmIy`x7sS=%2{2EKpb>dYZeN~`rh;U1ZQ=<RbP$}
zp=hmnK6>Kb4^G0Q(!1QsSkeJQQ(STT@!5zm<#C&48ET7L9Ap!%a$)e?H7At5dk~`3
zg+q&xaVBQ@FcF=Jk}V)r=iG_H8<26-yszw>0i#t%9W~D@J0~EE5Ouk1dG9Ivi!qJr
z5vD!X-s4K&L+A%b{)p212r>w?`;AEa73Og&jTo#tRa>5(LqqSwu*8R{D>3ru$5TKf
zpH9@xfx~@i{gYUBUI65bpF~~tm<}^AD43tTI{Y-z)SUuhI<Gsc^Qm9ZB^EJL(LGI8
zeU|K=52CNc232Zly|O=@dL3)S@O|-@hTo!j8bI4qUg4dWd*{gVE>W@pXk*Q<l-N%h
z4Xu3%c&tBeYF^r%m@-}X>9#xv-!Lb-EubA%cl>3;KSq9G3M&sD?0u02ufwWOLEO>c
z#nQ#mR~<=bspY_%dCr<+;i=>#oVBKE;pot3;2(8@%W|M<0AWGH_-P9=E*T$<)i&67
zR7a%!#_Ai${(yx>IyM6PlLm)>K#iRNWAS6oIRkS>@+?Z<&2*lO9k2||LFVa`)VgHd
z_i^gO`f)V|I`!LgSfHy@;q&A}-4nPJ(c(u?XrU;;bQpRSU6q;#KWS{|A#|0P4U2kw
z7z+u8Hc@vuu$sZUuE&h{5aSg;=uB?OuR15E^iSzRX*i#j&YBT@_Kp=yw@!Kit{)q6
z)|`yKiN3gyT7m#V7Z3j!r|aQUXvgrExYtj8fXW|6p|PrbkK!TLi}l7Cf1~PzMkmLa
zh@@Vs_hn2%5lah|{ne@8qXo6Iq9_W#!k3Y!v4Y+W7VUf*?L;GIB8pQl{h9YbH#!0W
zw-^Gwydw@mh8A}@pQ}!};xBI2;(yR$ub*yeb|>w((n^yo{3D_ZW^ad$bjg>mQrTH$
zwv$6g!61?k5<&Y*5L`jZ<1%(q`lOiuhvfMsS@%^gzwC=d7F^Kcr?ms`T&Eov!3;m5
zy?8;N1_O=4Kz{lpmKxL}^>@^L2SqHps6~s_T|-$d{)RpU3;sedsYlV$R0mu<V&4wl
za);EDbcoiAwhGzYe(m13Uq<s?@ej1PURtKbn@cOTxVyC49e0-2yOGm+2lRhZ7C1|r
zlm+h6Ey{xC(r#tJH%fOvO<C~0Qo3|i7W}Am52ufn?&I`lr30X?S|V?L88RBIP3PyO
z6Eo24_-pR?aV^<fdJ<*)oHdwNiYpZ^hs!NzsXFK^&8rkhams!+oqh&G$x`<q*FV|-
z<Gx{8au%#6>yA(m52QYhHj4gsv^bhuwD?DxNO1Uyey;C|AJ!7AL3uo{?A&2hucZ^p
zFW*PRAHp@XuDgAyb(T}Hk$KS<`>E)OOwlc|k%H*kj;C<J%Z4ALbpa>7;YwV0tWG)~
zWzJ;h>SGD}Of(T!&R3J}XEM68a1~Rk?M9^y=MLvbU!eONXFPS=9gf=_cN{`o9+=77
z@V_|!q76RGX4oaS6D3EkR2gQ`FEGprNCgi5aPQu|_DA;aU3lO*Yh80oOUbr1eaEA7
zwPeZTP#0GLsSqlU*>^!1s}%00$X>F9&h%1Z9hYd!NZ<;;<W5t0IWJ#hD(ClUb%o?>
zAMQ7*FetcIbU`OIa0c@$ZXZJ6@r&d#DoYgp7W|W#;6|kwr5X}G1mP#Iq5)16J`M@)
z5eii*e3%MJ1%+QT70#x@I8~D<r1>M7fo{>k!S_cI0I436_U%#%reDKMPTgQ=PnmAk
zUT$a~CV>^Cjmb`RUv1KUk_ro{khWA%XfYM~sovA?amRlAF|%nN@5vI{<fbtgI>CkP
z4?+li^%O#7=w%FbY6)<x(m&_L%O0g!lB_#Ri%y)@sAeq46mLen7xtl?J1M(uE_oL+
z9H`84;8t#`<Z|+GGYR-gCQ1P;Tc4PQni6$ONh&er82a#4I*$&d7L!AT(}9ona*<){
zc}S$D^769?4L+~mM+VBzpoq(-&YVW@)qVX6+y&}4(KsT9ivHV>dx2MCNInP2C*dA-
z>W@$?+q8kI`8o=*)O{T|(+gqXKICp4ng;mhLy5x2469MY>PC~*FexSq=Rsh!0qYF8
zm1Oyo5E$}hEr)IWbpP#&zeLN1J30TtRF$>hN|ER$NBkpK{G5Bi8+;57d}K?leHT^q
zozm5+6LLXy$3Jk#&pG4oI?~f#p^HWhcZqM&$Qu*gvDx7{WLm%8KZIt}oTB-OF0k;M
zWX1|wBHniY3Uz)&y^VHbL&3-$>dLl2r$6ZJ@~<i=xDgwqt*R(mQJ^A~chIkqR;aCk
zNOz}qyQ+5tB5IVZsexcyDBQ(2aSer_x{{lN&I&cs?e_)RwyT|?_K-@jTGr}s^F}-M
z6)Jz|flb`@&;mm<q^`tvZ+BE*1x+KT>LHaJ94!e1vD4~>mu;%CJ#6Ue>Pp%bUUhM;
z1YfI$f_|uQS<xC3!9Hz>*cB?}d>!Es9NpUK^?hp5whnA4kE3>1ySEBg<xm6hg*rpw
zh<f8%hpPK~bhX>t>DR|q^>s$|#fz6hm41b;>>8sxO#X>%d)T{u@v`Nlgx^m8UH;C9
zN?^o?$_j9KW+Zi?s=9P_n>V6*qk4!22Lhej)pmc-ANK10R<#XHL>w3@^8!Km(~3^!
zLxRUrcpAkArlJE;fh}^fphkm{Kzk6%z7B5~%AQuQ?!D~})#C{S13EEkoq7*U`Vd$;
zMkgHg>84SpxHDu80Yexr&yTE78?ZYc-mW&SU#B9pf+6TfySqbSIE%3LtKGq_U?}X}
zR#vruVgeTK@`rUbpcCiVwA$q&U86m&E(**JG`}kp_9IxmL3KXd<|AZS>+bq=)Em@=
zwXnZ6>LWqF8jN;r^@l0CggE>gul+QLW3}I?zblGPh{AO;%L61B2_cfjV26U8+b{B^
zyvy6Il35Rrt%~mME^6Q3@sIk?ALLVl=1Kv(R;}!rU%9x4U0X0o<hHTZ-XL|WFYHGI
z7?X+=DF_xVEMOEg&JF7N4b5t!)77jtYpzY|8kf6q4wV_@ZVC)zE|Z$Na1o-T;Ip;(
zom4^dY|^AU7`&F)ZGl$3gY&JN@9+oOJ9HC3&5YoA45=6*gcue)l;vs^Rsy4J0qY2^
z2(8dpFq)~1_YxyvOd}@d2Mf!#(sQTmmLdd2czJoO8U1A%u&sX68c@KpOGf7!bGz2J
z-0X30Si8ZqZo~QwW*$pG)p9ei+TGGj{+V>vZgkv&NsK3Da;k~BJ1*JF_A-VmH2i?H
zP_~6q8h^A?%X1*eTCTFycES*C6skk%^b=(Ct#tY%NHOSPTtoHaB5W7<9k}!z0j<YH
zelhSZprxQH?n$<Q?gQ-wtsF_G_ki~Q1@fQ_w^;SKRiZ>!u9PfyZ)BF9V#`%iCg%5B
zCKeOU-#tKGpWqV4&)D*el?wSSDZ^J*RJ^8W`t{1>ZTUOcbu(%gE-9T$7D(TTV>;SK
z7x*#}emjmGsPDfBTw8RKT*bB)({Yrctyh9FXHjuA2(^DHu%`%XC@M}`8;YjiZ*vr>
zJM)}HWih+6sM7kc1x01fBGpke9TE*i`Hsm<h4^6{PeAtpP_k#$3X1ZblQ-kHVe;mp
z{ON#GI7-o<pCKn8V_RuKapPnaY#y*(=-XylW;4nhkU$lTZd2%5*NML9!G;<6_W=3#
z1zSUrihY)%vir%uof8~I)v<|dikct`vD=~3kGpa|@+O@|(rF+ajdV29SyxmaE~<7E
zRXU2wU=y~D7V`f39_%~;J7S2*+NE@<2QKx%r5?D{1DAT>QV(3}flEDbsR#bC9uO}#
z(d#JYB;PB`Qw_94&@w^kQkjyZbbmu>H(ehi$#;kzoMG_%S|3^YzS~s>%;Y_T5M%Pa
zH-4`I8Cm}43+WK4>=qZn*x=)-SY)t0%9DJr*VuhvY>{vfm+?H&y#OWiJ6*)nW;CUn
z7pa`eYwc>GFS`dD)I5Dm&@IA2iSHARNWb?9ebFsU)_=9omvVR@#@h#R4q?lf^WDN8
zZY5<o*Tmi?=jHp|xE18Qv?t8}zY+O<c&@=CqG7)g^iP7G6Lf+Yh${rWM$qMgt`YP`
zLE8kqOVFKy=GOc7c=_I<9M@Xa&{(^A^$NADWotC3N7b5&s*1|;#Zk^J{^zRdipr%6
z4D|2Wr*eApQ@-bKmbYP#SH2&gjoa|#)QlK;dZSdvwYk)WF9T#eXX6u?jQebSB9rlu
zjps8NN7?u!CgU|5FJLmRv+>E9`JIhVVf(~*XXAyee~j_7u_Cr-Ok81dy~wsx%=X9y
z!c<_x8_)f!2@qKuy@5SvEd27!`eQD&VHZQLJK1;%t1nm05YOB2X6ab-!G<?W<@#Y(
zveB#;@6TrAqwj-f;}<uUmXSR69=$J?m1v!{qCbnpg2wk+fYH0MgdY>QTz_fZvfw@O
zjwLE`qwDKD<VpUtkmvg_z$$Q%e6R374?Lw>9E5Mlu|xYFWM|(MB*oYR24U+#Nq$F;
z9oi!zyeY@d7T{#3UM#eH-v(HhkiR)czK7$}S?+tv_X;}$V&Ua`Jixvn<co9s+0F6M
zaW4Z;>AN_{Pq(O7_QQV&T+6|q6!@+j`_BoyKF9y#94}^DRAi87&xz8jIH=w|!p<JC
ze!K~MtavyBocgUvp0L1EI*Wtw9Xa?!1Qy}B=l@y2sooAzFIb+g<@m+(Ws|Uzdt&u)
z`HSb>c>e!0m!HaBpDQXfk+Ir)Kji5R@Z9<PO>XDndHS%Bm)9ZE{7*T4@p|%eZs+28
z{RiMv(Qo}?s>)^k49BI_QCb9nsiSNrcP(%=!;NM%;A4F+@(h>1cs;otcrn%)Rg9Ok
z<O4odz1xKSvYhyQoBMz9I-D5C&bP+Fp8`()<gR<qk0bv(;A4Hiat8QV{bRw2{W9xx
zCeQP-y+wqhW_iAl^K=$)8ZT9h7vGbGQaQ(^_9)$rekex#cP~*#LF5i`|6xbWBe|FE
zfE|+0?f-S6UU|Ob`^T`eah!Vn<KWxJ!4u=)-v&<olk3k9$B{n*JiDbvvrmpAe-8Lu
zLnQ0><6QpY>x8Ko2pZq|oOrti_*n6Iosi!m<TKZ`c=)K};bD8I!pB+ze#W1Cv+i&R
z4}`ktsWyGS<S`x{vOvUxXXJsPr+aG`lMmM!|1inZ;qMvEd3-^g(f3WV%!@CH2*49?
zZj@@|8AG5g6v8(~j8G3fY#Yr*j4XfTW@L@0ZAM-`Xfrr^ipHOq8IKr8MVK$FNAzf0
z8#OZXNs~wK!oxT`J&)jnrq+<By)(4c+v#c5@vz(DjrK5KsH+=Ky8W#c)s=YcHKq`K
zdlm3_!+2Ef@dx$rcGiZD^LtvOU0vIuV&eF-<SbE-XU#^(x<*gqdZ!1UQDqCXGLQ3?
z^^SF})!8NdD=t9zG}6<k2@9HYBlE0vZ)kA1JsZ}n+0@wVX?8TY8_6pF_RANEa#z8d
zKOn2G&wL3+-+bkKx;9!$Ux)pzFT#xX6>{YLd_as(+_H=4J&a&$Hpai6%Z4ucZY{T%
zDlk4n!;@_K<}F(Q)!+-dY%KTNHBW0K<iTU~R{E~ZwE@;z5#V^Zjs73)I(iL2e5IFb
zZfhhWT;N~U@h<|iWsDC1voZR5FdH#G@XN+L9(;F~2@lhUf1_fVZ}rCf08f4bI4aLa
zGV80s>@xHjJ{ru%vc5|kEn0$3r*9KS5i-syBHO!k?^aMfY|svw!{?9wa5t;K(|Uh}
zqrp|Kd)o!q9*kCOjRx?=aG;e{5Qn!MI#@;P_8{yTR1X^^ct0XSUsiH4!FW&>_IG+o
zLFBqSbymSgt^(PL_7GTlfrVAjq=it32WW-ALrl|-Rv3|-p=!)mLqq0Ci|T>_?w7YK
z;6sL1p9(|+tH8q1g~cFiCI815+SkFU6W5eRlK01w%6%PC%w=Vs=sX;>mm>A$eYB)1
z%FIcg-z8Rsj9FjaZ%bM#1qIF3cLK+w;E=3e-j_>SE%fC6Q|7!RaJtW-y(XzI@82b@
z7X`GfL;WQ6aizr5jrheWG@~!?^Cgx0S%$P>L*|KY#zA{UvVOTAAgR2skp4?KNk0XB
z+Iy0`+&7T49_5sB{Wnm??nZ|CRO-w9g$$)eBgy)6+uw^a(r+LkB)JbEsoakveY!Qw
z)i>_z4F5=9?ng>0_wA^R64hl+aWLef*mle8YsmeLlV)M$iv=&~gW%2ja{oh8>8~^+
zc}c&Sqc5);B|W1^O@qpMCHmbQeYu|^Y3?>nZu@^A^yT=;>u5<&%YhRWs)9=LV`QlP
zQomm{N+j(x*vxNk{m-Dpte@G(nPaG=sL+&Tze(sQGDSFO4pEZ#dGh~3<jPB4(qBV|
zx>)MV`^xHavNjrT1~<w}{nt=HE=qm5e^f8@%cP>9Y7YMnc#1u#FZY?`|Lc(dmqW&<
ztXIatZs?lpm-|sSFET26#2}epsW0jI9DP=)8nTrJ5uCx`SL#XNBY{c(<^6{$^qXXX
zP*A0!pjJ3f{tNL;snlPPL5vK^QZiE+dq#=z+awJ3iwQvIAqNiWzg&N*ILAe9;A9Oa
bY*S9a%6g4by2lw?f5|FCVsef`4$J-zzjPD)

literal 0
HcmV?d00001

-- 
2.17.1

