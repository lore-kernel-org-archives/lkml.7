Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA93C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F9E20640
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 23:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="pH0MF83y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfLBXth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 18:49:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40502 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfLBXth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:49:37 -0500
Received: from zn.tnic (p200300EC2F0AE80079FCF5458EAE7CF0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e800:79fc:f545:8eae:7cf0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D46F71EC0C25;
        Tue,  3 Dec 2019 00:49:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1575330575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WuiQHq9zpFmXRsOoUwxXHpXttOQXiJ6gAbvSOzI5Ke8=;
        b=pH0MF83ydDJsSuqhX1Rb//UEBwqlMDt0LyUKPtF20ttVdKPlCUK1bQuYpzJLnYoJex9Lui
        yLD/nBwGTeklTGUqCZmxTCHuzYFUzwdbbhHhVNHfMnlffvM+bv9RRrYeI1tnjquOryaBqc
        R4wz7divYjJZAtRRCeu2hvJEhGOVaaI=
Date:   Tue, 3 Dec 2019 00:49:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        Andre Przywara <Andre.Przywara@arm.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v8 01/13] selftests/resctrl: Add README for resctrl tests
Message-ID: <20191202234927.GE32696@zn.tnic>
References: <1574901584-212957-1-git-send-email-fenghua.yu@intel.com>
 <1574901584-212957-2-git-send-email-fenghua.yu@intel.com>
 <20191128072338.GA17745@zn.tnic>
 <20191202185334.GA220960@romley-ivt3.sc.intel.com>
 <20191202230642.GD32696@zn.tnic>
 <20191202234244.GC220960@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191202234244.GC220960@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 03:42:44PM -0800, Fenghua Yu wrote:
> Should I send v9 patch set with only the Co-developed-by changes?

You can wait for other people's review first. And since you sent them
during the merge window, you probably should wait longer, since people
are busy with fixing fallout from the current stuff going upstream and
not reviewing anything new.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
