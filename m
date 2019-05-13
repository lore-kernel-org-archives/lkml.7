Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B174FC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8417F20989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="F2PsFwaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfEMHHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:07:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54542 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfEMHHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:07:32 -0400
Received: from zn.tnic (p200300EC2F29E500E0EF2AA1CE3E4EBD.dip0.t-ipconnect.de [IPv6:2003:ec:2f29:e500:e0ef:2aa1:ce3e:4ebd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D0ABE1EC023E;
        Mon, 13 May 2019 09:07:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557731250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BqTymM6cecZN0+v09mFot3RRl0PfUeXwhhA6+qtKHVw=;
        b=F2PsFwaEy57xSepYh4jAHbU3sLz7vFYY4+9exXUN3fxBuYnXpnmiC66/CcHEUACdnQzXmb
        areuOFT8HBfjp6l38HhQvm2LVdgXNoZjzc+Wb1bMeR9KN5UCe2BkR3YhKnzVgUTBNIj9pw
        lJ+09KOJkoo5ZjzZNcts5EOLORjPcSo=
Date:   Mon, 13 May 2019 09:07:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     j-nomura@ce.jp.nec.com, kasong@redhat.com, dyoung@redhat.com,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190513070725.GA20105@zn.tnic>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190513014248.GA16774@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan,

On Mon, May 13, 2019 at 09:43:05AM +0800, Baoquan He wrote:
> Can this patchset be merged, or picked into tip?

what is this thing that happens everytime after a kernel is released and
lasts for approximately 2 weeks?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
