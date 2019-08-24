Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7157C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 02:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D09921848
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 02:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bJhYAOth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfHXCh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 22:37:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2782 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfHXCh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 22:37:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d60a3050000>; Fri, 23 Aug 2019 19:37:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 23 Aug 2019 19:37:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 23 Aug 2019 19:37:56 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 24 Aug
 2019 02:37:56 +0000
Subject: Re: linux-next: Tree for Aug 23
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190823192658.49e6f68d@canb.auug.org.au>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <47bf2ffc-a737-e4ba-8d37-96472f307094@nvidia.com>
Date:   Fri, 23 Aug 2019 19:37:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823192658.49e6f68d@canb.auug.org.au>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566614278; bh=UVzZgCMP0diU+WGz9ZHXGnIikzh+FMgpaDM8zKhy/Kc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bJhYAOthJWCyPO1IXEQMvvN9zFHn/klDQqK2bN+rmiV3K2z7/UDjMlYlB1WT1a0lk
         t0CMBokMFlyKGVPOxC19joHKRrMUhZUfaqJLDYF9lk3e09w4LqwGCw+w0IC8q8aUTW
         tarcwteeak/8cvorjRF0fIsTmw9ju46XeXxz12Xc4OQMeeM+dZl6lTOfuFsg04LvLE
         hRRrWL+jED7imauGbfPzzSkhts7Ond4x5nlfQsQGSpdv6ESFN1cfo0bZblk7NQdXih
         cruplpO4AJSiOiNeFMW5lTvz9Ba23t1kbWys9ALVx4keRMLaKN04FRFDl/1nfaGvkm
         3SClxWeStLBKQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/19 2:26 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190822:
> 
> The thermal tree gained a conflict against the jc_docs tree.
> 
> The rdma tree gained a conflict against the rdma-fixes tree.
> 
> The net-next tree gained conflicts against the pci tree.
> 
> The crypto tree gained a conflict against Linus' tree.
> 
> The drm tree gained a conflict against the drm-fixes tree.

Hi,

Even though I saw email proposing fixes for one (maybe both) of the 
following warnings, I'm still seeing them in this linux-next:

WARNING: "ahci_em_messages" [drivers/ata/libahci] is a static EXPORT_SYMBOL_GPL
WARNING: "ftrace_set_clr_event" [vmlinux] is a static EXPORT_SYMBOL_GPL

...and obviously these can be trivially fixed by:

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index e4c45d3cca79..bff369d9a1a7 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -175,7 +175,6 @@ struct ata_port_operations ahci_pmp_retry_srst_ops = {
 EXPORT_SYMBOL_GPL(ahci_pmp_retry_srst_ops);
 
 static bool ahci_em_messages __read_mostly = true;
-EXPORT_SYMBOL_GPL(ahci_em_messages);
 module_param(ahci_em_messages, bool, 0444);
 /* add other LED protocol types when they become supported */
 MODULE_PARM_DESC(ahci_em_messages,
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c7506bc81b75..648930823b57 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -787,7 +787,7 @@ static int __ftrace_set_clr_event(struct trace_array *tr, const char *match,
        return ret;
 }
 
-static int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
+int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 {
        char *event = NULL, *sub = NULL, *match;
        int ret;



...which I didn't create patches for, because I expect they are already
in flight. But if those somehow got lost or skipped, then here's an early
warning that these fixes still need to be applied.


thanks,
-- 
John Hubbard
NVIDIA
