Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CB7C10F00
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F52E206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s2ioySkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfCGAWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:22:38 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48126 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGAWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:Cc:From:References:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U0txdzxv3YC87Z92rfdR8l1bQdbYrNdy3XClb61KJEQ=; b=s2ioySkEvd+qUm0qWtxTM51TvA
        cEqL9GPJBNBLX1/jUJ3C8ixcl5hm1IPpuLmy3ckcl/3wOeIdcd8zyXVgj9OUBp16jwMOeIUxVPXXk
        6N3u93AcIPn7Qo2IKO5emIIDZWYltrtYGxOuoj8dLR0hMPlVXK5KhudLFbExJRChv+ChiOcpUDeYz
        0+YCD1PY4wzPAdYhc/Q8Xk8yfIpvezuZ2biX6Dia2hPNf6jZ6ack7oozZG+QBm1FPWnDCgtGpVMoW
        mS2W7xDHiarQdxAsRgKVz23tEEpCEc/8Zc6EclO8XKiBG/Rf58wAlueRqZyK2KHg4J5pfk3dVqs/E
        VqQFg1tw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1gnw-0007Fb-GR; Thu, 07 Mar 2019 00:22:33 +0000
Subject: Re: mmotm 2019-03-05-16-36 uploaded (zstd)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
References: <20190306003721.eX4wF%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>
Message-ID: <a02fdae6-1f3c-6725-88e5-73316017f5ac@infradead.org>
Date:   Wed, 6 Mar 2019 16:22:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190306003721.eX4wF%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 4:37 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-03-05-16-36 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> http://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.

on x86_64:

../lib/zstd/decompress.c: In function 'ZSTD_decompressStream':
../lib/zstd/decompress.c:416:2: warning: argument 1 null where non-null expected [-Wnonnull]
  memcpy(dst, src, srcSize);
  ^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ../arch/x86/include/asm/string.h:5:0,
                 from ../include/linux/string.h:20,
                 from ../lib/zstd/mem.h:24,
                 from ../lib/zstd/bitstream.h:54,
                 from ../lib/zstd/fse.h:228,
                 from ../lib/zstd/decompress.c:32:
../arch/x86/include/asm/string_64.h:14:14: note: in a call to function 'memcpy' declared here
 extern void *memcpy(void *to, const void *from, size_t len);
              ^~~~~~
../lib/zstd/decompress.c:426:2: warning: argument 1 null where non-null expected [-Wnonnull]
  memset(dst, *(const BYTE *)src, regenSize);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from ../arch/x86/include/asm/string.h:5:0,
                 from ../include/linux/string.h:20,
                 from ../lib/zstd/mem.h:24,
                 from ../lib/zstd/bitstream.h:54,
                 from ../lib/zstd/fse.h:228,
                 from ../lib/zstd/decompress.c:32:
../arch/x86/include/asm/string_64.h:18:7: note: in a call to function 'memset' declared here
 void *memset(void *s, int c, size_t n);
       ^~~~~~



-- 
~Randy
