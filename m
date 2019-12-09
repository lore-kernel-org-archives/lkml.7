Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36509C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D2720828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nth41AYD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLIQ01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:26:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQ01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tgG420DZ2cwuUBenbzd7C2H66aW1h6tEZ2bZ6ltYU8Y=; b=Nth41AYDV8uI93T6PJ0xDT7rw
        M2OyFPd0KW4kuSuE1MzA8ToD2raOoxAZszRy0HIciY6DVsILRd1EbZ2PV1E7WRWAlu4+iKuk0WV31
        LKaiuhstmqiOa53KHurQfU2A9fMiudm98akyTW152AZzBGbEbgqNE4Guxq6I9dZ6/NSe1eaGOhHB6
        u1JEGS0cW9H/nTjO8MesRTg5vcrM/XXYLDOrTPx2sc59+VEBM14Lro2qmjmu0Xy0sqNPV204EtHqK
        88uGOTq9OwYXOLLsUiCzZdftRMhl+OqBsVCsi+4jenfdnd9q/Ab/d+maIM3wBkPlIYAk3eTOs8nIf
        bsYmafbTA==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieLrX-0004oN-0l; Mon, 09 Dec 2019 16:26:19 +0000
Subject: Re: [PATCH] Documentation: x86: fix boot.rst warning and format
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <c6fbf592-0aca-69d9-e903-e869221a041a@infradead.org>
 <20191209161340.kdsikc2hvbhmpi6k@tomti.i.net-space.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a934c91b-0c9f-59d4-ee44-bcd7e9b20334@infradead.org>
Date:   Mon, 9 Dec 2019 08:26:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209161340.kdsikc2hvbhmpi6k@tomti.i.net-space.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/19 8:13 AM, Daniel Kiper wrote:
> On Sun, Dec 08, 2019 at 08:25:10PM -0800, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix a Sphinx documentation format warning by breaking a long line
>> into 2 lines.
>>
>> Also drop the ':' usage after the Protocol version numbers since
>> other Protocol versions don't use colons.
>>
>> Documentation/x86/boot.rst:72: WARNING: Malformed table.
>> Text in column margin in table line 57.
>>
>> Fixes: 2c33c27fd603 ("x86/boot: Introduce kernel_info")
>> Fixes: 00cd1c154d56 ("x86/boot: Introduce kernel_info.setup_type_max")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: Daniel Kiper <daniel.kiper@oracle.com>
> 
> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
> 
> What can I do next time to avoid mistakes like that? I suppose that
> I can run something to get this warning but I do not know what exactly
> it should be.

I just do:
$ mkdir DOC1
$ make O=DOC1 htmldocs &>doc1.out

doc1.out will contain the build log for the documentation.
It will be large.  :(
Just grep (or use editor search) for the file(s) that you are
interested in.


thanks.
-- 
~Randy

