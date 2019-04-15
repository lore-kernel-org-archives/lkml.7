Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F7C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4422073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 09:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="oClUQO4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfDOJJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:09:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45756 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbfDOJJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 05:09:32 -0400
Received: from zn.tnic (p4FED3D80.dip0.t-ipconnect.de [79.237.61.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D5A11EC030F;
        Mon, 15 Apr 2019 11:09:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555319371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Rc7FredvumHV4fAHZEeCJLzJtiSM6949KosXc3H5Jnw=;
        b=oClUQO4zjMtsvKAmOCH+azO3rjQOZs12chfkskl1zPldmptkUEh4JNcpor1n5Ex94EsmN9
        6GXcUqgR582W6e3QeYL+rIWFKWx3UOoQeZAXIgjzjGDIYRN42mDCnQvtQkh79vJp/SyA19
        49ySuAoCI0kVahPymOJvzXaKY+pU3Xs=
Date:   Mon, 15 Apr 2019 11:07:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Kairui Song <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190415090717.GA29317@zn.tnic>
References: <20190411083738.GC30080@zn.tnic>
 <2946b5e3-90bf-d617-16a4-d2225b490b5d@ce.jp.nec.com>
 <DFC5B552-9B44-422B-8EAE-A32C24BB7A88@alien8.de>
 <e88fda9c-bd5a-d263-cd8a-380828dd6a93@ce.jp.nec.com>
 <C54C5A30-62D9-45C4-8036-88D255FD92A1@alien8.de>
 <20190411125822.GE30080@zn.tnic>
 <20190412025416.GA11070@jeru.linux.bs1.fc.nec.co.jp>
 <20190412084956.GC19808@zn.tnic>
 <20190412133528.GD19808@zn.tnic>
 <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc2c1dbe-4fb3-fb7d-0540-c04734fc15cb@ce.jp.nec.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 07:01:54AM +0000, Junichi Nomura wrote:
> OK. Then I'll go back to v3 and make sure to hang when
> something is wrong during kexec boot on EFI system.

No need - I have it here locally. I'll clean it up and post it for
review.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
