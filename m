Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF5EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2892175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfCTBu4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:50:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:5867 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfCTBu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:50:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 18:50:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,246,1549958400"; 
   d="scan'208";a="135736603"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga007.fm.intel.com with ESMTP; 19 Mar 2019 18:50:55 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 19 Mar 2019 18:50:55 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 19 Mar 2019 18:50:55 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.74]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.252]) with mapi id 14.03.0415.000;
 Wed, 20 Mar 2019 09:50:53 +0800
From:   "He, Bo" <bo.he@intel.com>
To:     Jiri Kosina <jikos@kernel.org>
CC:     "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Jun" <jun.zhang@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
Subject: RE: must hold the driver_input_lock in hid_debug_rdesc_show
Thread-Topic: must hold the driver_input_lock in hid_debug_rdesc_show
Thread-Index: AdTaDWtNLTEcOrQfQrCEZYJMmjpu/wEEXTCAACgVOfA=
Date:   Wed, 20 Mar 2019 01:50:52 +0000
Message-ID: <CD6925E8781EFD4D8E11882D20FC406D52A6340D@SHSMSX104.ccr.corp.intel.com>
References: <CD6925E8781EFD4D8E11882D20FC406D52A6168C@SHSMSX104.ccr.corp.intel.com>
 <nycvar.YFH.7.76.1903191541410.19912@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1903191541410.19912@cbobk.fhfr.pm>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmMzOGZiN2EtMzc1OS00NDljLWI4MjMtNWFkYmRkMjYwN2JhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTHRJdm52MENHYzZMYUpmVGxENEY3Zlh3VTUyNVwvdVFPa1A1NDJ5a3R0Rmh1aEJmMTgwWE5VdVRpTXNRYjVLRTMifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thanks, without the patch we can reproduce with the way in 10 hours Suspend/Resume test, with the test, we can't reproduce for 30 hours.

-----Original Message-----
From: Jiri Kosina <jikos@kernel.org> 
Sent: Tuesday, March 19, 2019 10:42 PM
To: He, Bo <bo.he@intel.com>
Cc: benjamin.tissoires@redhat.com; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Zhang, Jun <jun.zhang@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>
Subject: Re: must hold the driver_input_lock in hid_debug_rdesc_show

On Thu, 14 Mar 2019, He, Bo wrote:

> we see the below kernel panic logs when run suspend resume test with 
> usb mouse and usb keyboard connected.
> 
> the scenario is the userspace call the hid_debug_rdesc_show to dump 
> the input device while the device is removed. the patch hold the 
> driver_input_lock to avoid the race.
> 
> [ 5381.757295] selinux: SELinux:  Could not stat
> /sys/devices/pci0000:00/0000:00:15.0/usb1/1-2/1-2:1.0/0003:03F0:0325.0320/input/input960/input960::scrolllock:
> No such file or directory.
> [ 5382.636498] BUG: unable to handle kernel paging request at 0000000783316040
> [ 5382.651950] CPU: 1 PID: 1512 Comm: getevent Tainted: G     U     O 4.19.20-quilt-2e5dc0ac-00029-gc455a447dd55 #1
> [ 5382.663797] RIP: 0010:hid_dump_device+0x9b/0x160 [ 5382.758853] 
> Call Trace:
> [ 5382.761581]  hid_debug_rdesc_show+0x72/0x1d0 [ 5382.766343]  
> seq_read+0xe0/0x410 [ 5382.769941]  full_proxy_read+0x5f/0x90 [ 
> 5382.774121]  __vfs_read+0x3a/0x170 [ 5382.788392]  
> vfs_read+0xa0/0x150 [ 5382.791984]  ksys_read+0x58/0xc0 [ 5382.801404]  
> __x64_sys_read+0x1a/0x20 [ 5382.805483]  do_syscall_64+0x55/0x110 [ 
> 5382.809559]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Signed-off-by: he, bo <bo.he@intel.com>
> Signed-off-by: "Zhang, Jun" <jun.zhang@intel.com>

I rewrote the changelog to explain the situation a bit more clearly, and applied. Thanks,

--
Jiri Kosina
SUSE Labs

