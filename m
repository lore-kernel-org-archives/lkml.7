Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72B6C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B18D206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z7aM5UTw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfHLUeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:34:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59830 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLUeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GBM94Q/OTQSku+z+3GFrDGRbKILOPX2GboQOlG2X8Rw=; b=z7aM5UTw64BJPzgzRRuNu84mRi
        Z6JR8tJZzwLY9ubRiQ8yZAaoEkLo29CPPNjrBttuzYvcmJhNeBc919RK7wl2pTYQcURgw3OEAaz0k
        pPCa0J2exqf5RdUOarENp/peLbLv4nHKSSE755yQtYOzBouIz3ooR+hSxELGRti80Xa3E3P35Zv4/
        B56UMmyYqadUtWL9YNb4Z7rrMoo9a0z7Z3j+EyeiLjlEmZ4rUf2P3r5dL1XQKv1Iu2qiiVJVJCcjP
        h6gzBw3hOi6S4fmtCkyVC2CiNHyK1xepomHZO89Ogi8peyVxcA9f7WfHBUSOeP4+L/lrRtJTeKyMp
        nuubTBaw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxH0v-0004g4-ME; Mon, 12 Aug 2019 20:33:57 +0000
Subject: Re: Build regressions/improvements in v5.3-rc4
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <20190812102049.27836-1-geert@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a74dd048-8501-a973-5b03-eefbc83d7f79@infradead.org>
Date:   Mon, 12 Aug 2019 13:33:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812102049.27836-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/19 3:20 AM, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.3-rc4[1] compared to v5.2[2].
> 
> Summarized:
>   - build errors: +5/-1
>   - build warnings: +137/-136
> 
> JFYI, when comparing v5.3-rc4[1] to v5.3-rc3[3], the summaries are:
>   - build errors: +0/-4
>   - build warnings: +105/-69
> 
> Happy fixing! ;-)
> 
> Thanks to the linux-next team for providing the build service.
> 
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d45331b00ddb179e291766617259261c112db872/ (all 242 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0ecfebd2b52404ae0c54a878c872bb93363ada36/ (all 242 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e21a712a9685488f5ce80495b37b9fdbe96c230d/ (all 242 configs)


> *** WARNINGS ***
> 
> 137 warning regressions:

>   + warning: unmet direct dependencies detected for MTD_COMPLEX_MAPPINGS:  => N/A

It would be Really Good if there was some automated way to know which
of the 242 configs this is from (instead of you having to grep and reply to
email or someone/me having to download up to 242 log files).

-- 
~Randy
