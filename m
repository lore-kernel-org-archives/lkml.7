Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC61C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3016120851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfCHQgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:36:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35040 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:36:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id e17so14561281pgd.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 08:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmKEcNMTVy8VoMuvnQJcGdrDMFCm/RyUclNMu/hBM2I=;
        b=tBuq3rIlpWVIWqVKjYKGyzqBGJFKOQrN3/ahqvHXh0mINrGPhXrVze8jsGOGZGfh/2
         fh2goc9DIX43qTRKVOqAYdfT7QINvQ5NacQDbftg4ZoiJC2Dr2BRYz573gXG3UcAiezB
         6JU01PQ2NNHAF5k2RmIwbSvVf5SRl919KCFUe3VWBFTnscXM/mqdsZwZisWPROZ69IsR
         lNv6277gYVwxHBVHrm5qzkGbB2izLsrxZ78sQTNM/W4t4Mt2Aka58HXDwFK1cv6iG45/
         XPttxjCKkZkpraJtFQiq2ebX/ZiwW2t3EOKzZ2Ya18QPzxJopJNFnIKJ9nX3O3xipcXw
         oPIA==
X-Gm-Message-State: APjAAAX/dkZKRDo+l+yRvpM5IlN0i1Lhd3CYgVhj2og2TqO9WrSpgANB
        8+SLxItN/iEInR1B0KPLHMk=
X-Google-Smtp-Source: APXvYqy+5IxHJCC6AeY6hdM3P7yljGfh2/yDMXbnVGm5JpeMkdUfuZvKaQbnBBYy+gByDnEl128U9g==
X-Received: by 2002:a17:902:2c01:: with SMTP id m1mr19731405plb.314.1552063006722;
        Fri, 08 Mar 2019 08:36:46 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s4sm11452057pfe.16.2019.03.08.08.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 08:36:46 -0800 (PST)
Message-ID: <1552063004.45180.19.camel@acm.org>
Subject: Re: 669de8bda8 ("kernel/workqueue: Use dynamic lockdep keys for
 .."):  WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:995
 lockdep_register_key
From:   Bart Van Assche <bvanassche@acm.org>
To:     kernel test robot <lkp@intel.com>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Date:   Fri, 08 Mar 2019 08:36:44 -0800
In-Reply-To: <5c81f407.dqtEdGUmHMiobjjO%lkp@intel.com>
References: <5c81f407.dqtEdGUmHMiobjjO%lkp@intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-03-08 at 12:48 +-0800, kernel test robot wrote:
+AD4 +AFs    1.855169+AF0 spin+AF8-lock-torture: lock+AF8-torture+AF8-stats task started
+AD4 +AFs    2.565387+AF0 workingset: timestamp+AF8-bits+AD0-14 max+AF8-order+AD0-17 bucket+AF8-order+AD0-3
+AD4 +AFs    2.567522+AF0 NFS: Registering the id+AF8-resolver key type
+AD4 +AFs    2.568478+AF0 Key type id+AF8-resolver registered
+AD4 +AFs    2.569072+AF0 Key type id+AF8-legacy registered
+AD4 +AFs    2.570808+AF0 WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:995 lockdep+AF8-register+AF8-key+-0x37/0x386
+AD4 +AFs    2.571658+AF0 CPU: 0 PID: 1 Comm: swapper Not tainted 5.0.0-rc8-00054-g669de8b +ACM-496
+AD4 +AFs    2.571658+AF0 Hardware name: QEMU Standard PC (i440FX +- PIIX, 1996), BIOS 1.10.2-1 04/01/2014
+AD4 +AFs    2.571658+AF0 EIP: lockdep+AF8-register+AF8-key+-0x37/0x386
+AD4 +AFs    2.571658+AF0 Code: 20 45 65 94 01 83 15 24 45 65 94 00 81 fe 00 00 80 92 72 2e 81 fe 00 d0 88 95 73 26 83 05 40 45 65 94 01 83 15 44 45 65 94 00 +ADw-0f+AD4 0b 83 05 48 45 65 94 01 83 15 4c 45 65 94 00
+AD4 83 c4 1c 5b 5e 5f
+AD4 +AFs    2.571658+AF0 EAX: 9586d254 EBX: 9586d1c0 ECX: 944f9cd8 EDX: 00000000
+AD4 +AFs    2.571658+AF0 ESI: 9586d254 EDI: 9586d274 EBP: 975a9ee4 ESP: 975a9ebc
+AD4 +AFs    2.571658+AF0 DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00210246
+AD4 +AFs    2.571658+AF0 CR0: 80050033 CR2: 00000000 CR3: 1c4a5000 CR4: 00340690
+AD4 +AFs    2.571658+AF0 DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
+AD4 +AFs    2.571658+AF0 DR6: fffe0ff0 DR7: 00000400
+AD4 +AFs    2.571658+AF0 Call Trace:
+AD4 +AFs    2.571658+AF0  ? debug+AF8-mutex+AF8-init+-0x4b/0x63
+AD4 +AFs    2.571658+AF0  ? +AF8AXw-mutex+AF8-init+-0x59/0x6c
+AD4 +AFs    2.571658+AF0  alloc+AF8-workqueue+-0x227/0x84e
+AD4 +AFs    2.571658+AF0  ? proc+AF8-create+-0x3e/0x52
+AD4 +AFs    2.571658+AF0  ? trace+AF8-event+AF8-define+AF8-fields+AF8-smb3+AF8-rw+AF8-err+AF8-class+-0x1b9/0x1b9
+AD4 +AFs    2.571658+AF0  init+AF8-cifs+-0x159/0x72f
+AD4 +AFs    2.571658+AF0  do+AF8-one+AF8-initcall+-0x2c4/0x6bf
+AD4 +AFs    2.571658+AF0  kernel+AF8-init+AF8-freeable+-0x6ef/0x841
+AD4 +AFs    2.571658+AF0  ? rest+AF8-init+-0x473/0x473
+AD4 +AFs    2.571658+AF0  kernel+AF8-init+-0x1e/0x26b
+AD4 +AFs    2.571658+AF0  ? schedule+AF8-tail+AF8-wrapper+-0x9/0xc
+AD4 +AFs    2.571658+AF0  ret+AF8-from+AF8-fork+-0x1e/0x28
+AD4 +AFs    2.571658+AF0 irq event stamp: 410062
+AD4 +AFs    2.571658+AF0 hardirqs last  enabled at (410061): +AFsAPA-93a2ac73+AD4AXQ +AF8-raw+AF8-spin+AF8-unlock+AF8-irqrestore+-0x133/0x17e
+AD4 +AFs    2.571658+AF0 hardirqs last disabled at (410062): +AFsAPA-92801bca+AD4AXQ trace+AF8-hardirqs+AF8-off+AF8-thunk+-0xc/0x10
+AD4 +AFs    2.571658+AF0 softirqs last  enabled at (409970): +AFsAPA-93a2da14+AD4AXQ +AF8AXw-do+AF8-softirq+-0x904/0xa1d
+AD4 +AFs    2.571658+AF0 softirqs last disabled at (409965): +AFsAPA-92813eb9+AD4AXQ do+AF8-softirq+AF8-own+AF8-stack+-0x3d/0x51
+AD4 +AFs    2.571658+AF0 ---+AFs end trace c4eabde80fbbdbf0 +AF0----
+AD4 +AFs    3.753943+AF0 String selftests succeeded

The following patch should fix this: +AFs-PATCH+AF0 kernel/wq: Fix a alloc+AF8-workqueue()
error path. See also 
https://lore.kernel.org/lkml/20190303220046.29448-1-bvanassche+AEA-acm.org/

Bart.
