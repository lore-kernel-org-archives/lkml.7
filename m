Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C957C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 04:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAA920880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 04:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MKNxN8gQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfDHElo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 00:41:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfDHElo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 00:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wMBjlWuGsAyfrVdkpwbApCIWTxEKhh1pW4e+12p7PMk=; b=MKNxN8gQuGYthg/X5PAaY9PQz
        EEQWLcxtXvpxCC+ekfaVAGIaaWlKGgIJvOHFFsh0YylPF68WmANWm+boZn13KcUCOvKP+SVtMO5hT
        t4YocfZ023GLS0R21BKz+n2k+yD7sRBXoGB/BaU59tpNYGG5onqngmz33BPYFZnUJBTkioFKI5CAq
        LF/TjckWQkeNnA+2/zz7lrb1H1HL0kWaEGdgLndw6KOhFyn5xk6KtuhC3TJkqe8iagYBnYe8ZC/ZU
        08BdIkYQC0dKA8UhOukXFn/ogAehs6T2x+ZXrq3n2BRB1fD9hSJH3YZAFh0kYUbwgYk+72XN6O/sz
        HpQeGHBGw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDM6J-00014W-82; Mon, 08 Apr 2019 04:41:43 +0000
Subject: Re: [PATCH -next] MAINTAINERS: mark lima mailing list as moderated
To:     Qiang Yu <yuq825@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        lima@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <9138d8e8-5390-0650-9bc3-050b869e978c@infradead.org>
 <CAKGbVbugBGrxfHm3k7WB+FS_O-Bjj9PyKrSDteTy1sra=nd6cw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5e771518-a673-8d1f-fc89-91a837ebdaf0@infradead.org>
Date:   Sun, 7 Apr 2019 21:41:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAKGbVbugBGrxfHm3k7WB+FS_O-Bjj9PyKrSDteTy1sra=nd6cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/19 6:37 PM, Qiang Yu wrote:
> Looks good for me, patch is:
> Reviewed-by: Qiang Yu <yuq825@gmail.com>
> 
> Should I apply this patch to drm-misc in this case? Or this patch will be
> submitted in other kernel tree and back merged to drm-misc?

I expect applying it to drm-misc is the right thing here, but maybe
Daniel or someone else there can answer this.

Thanks.

> Regards,
> Qiang
> 
> On Mon, Apr 8, 2019 at 3:12 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Note that the lima mailing list is moderated.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Qiang Yu <yuq825@gmail.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: lima@lists.freedesktop.org
>> ---
>>  MAINTAINERS |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- mmotm-2019-0405-1828.orig/MAINTAINERS
>> +++ mmotm-2019-0405-1828/MAINTAINERS
>> @@ -5226,7 +5226,7 @@ F:        Documentation/devicetree/bindings/dis
>>  DRM DRIVERS FOR LIMA
>>  M:     Qiang Yu <yuq825@gmail.com>
>>  L:     dri-devel@lists.freedesktop.org
>> -L:     lima@lists.freedesktop.org
>> +L:     lima@lists.freedesktop.org (moderated for non-subscribers)
>>  S:     Maintained
>>  F:     drivers/gpu/drm/lima/
>>  F:     include/uapi/drm/lima_drm.h
>>
>>


-- 
~Randy
