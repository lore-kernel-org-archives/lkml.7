Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BF1C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA7520818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RlacLjhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfDKJkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:40:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41300 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbfDKJkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:40:43 -0400
Received: from [10.119.185.175] (x2f7f9af.dyn.telefonica.de [2.247.249.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1DA871EC01B6;
        Thu, 11 Apr 2019 11:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554975642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+knrmEfAOSJTLQ+iPKUxdXf6weEuJC2kEpnf2fZnOQM=;
        b=RlacLjhm75LsWj72IbOZTe7hz+7Yt3pbzrA+8K7/pvrKvKG9CQRusqrjVEUXaoXbmmE5GR
        y6whlEr/B7YgufXhl9aAE9+zh1/ULRMYB5VCcCR5IqLVu0GLwoIaLrvL2k79VmqS1uNhuk
        bJyAWPG42uommSLW+mIHr9LE/wjSc/0=
Date:   Thu, 11 Apr 2019 11:40:39 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp> <20190410171431.GE26580@zn.tnic> <7cbc096d-0548-18b1-a335-8ba114f234a7@ce.jp.nec.com> <20190411080927.GA30080@zn.tnic> <e4de0520-ade8-2834-dadf-7af68701356b@ce.jp.nec.com> <20190411083738.GC30080@zn.tnic> <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com> <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de> <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on kexec-ed kernel
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
CC:     Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 11, 2019 11:32:59 AM GMT+02:00, Junichi Nomura <j-nomura@ce=2Ejp=
=2Enec=2Ecom> wrote:
>No=2E But that's why I asked the question=2E Do you mean putting
>the above code in efi_get_rsdp_addr()?

I'll do what I mean whan I get back later=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
