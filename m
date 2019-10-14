Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA01ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C04217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="HMg/sOnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbfJNQ5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:57:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49074 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfJNQ5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:57:39 -0400
Received: from zn.tnic (p200300EC2F065800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D53A71EC06FB;
        Mon, 14 Oct 2019 18:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571072258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0YE7H57bfJwdjx4DkWtJCZeY4gQA/uBCTTivUvijTW0=;
        b=HMg/sOnzha2w7Dwsz9tzp1Cw6eE554QdB3OYsG3P1NDa7/qXmeZuZ4zQiKv1QWj+E8Drlb
        F1aXW2lV32y84+KkyzjXBhMyB9GPZtYbDt3c4W8I1m7ppzgej4eoEsjKeRfATzVa8yBRE4
        0y2WbT83RFVHxKbtkVbpu41nntdlZ54=
Date:   Mon, 14 Oct 2019 18:57:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     John Garry <john.garry@huawei.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        tony.luck@intel.com, Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: edac KASAN warning in experimental arm64 allmodconfig boot
Message-ID: <20191014165735.GF4715@zn.tnic>
References: <304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com>
 <dc974549-6ea4-899d-7f3a-b2fcfafe1528@arm.com>
 <a5e3c4eb-57ed-d4bc-a771-47472c5fb088@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5e3c4eb-57ed-d4bc-a771-47472c5fb088@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 05:56:02PM +0100, John Garry wrote:
> BTW, I am not sure if my response to Boris was rejected due to attachments,
> as but it is here:
> 
> https://lore.kernel.org/linux-edac/dc974549-6ea4-899d-7f3a-b2fcfafe1528@arm.com/T/#ma0e122ca0eda9d80e869af179352f75037146d3c

No, all good. It went through.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
