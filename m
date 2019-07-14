Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75D8C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C0420838
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gfEBOC/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfGNRjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 13:39:41 -0400
Received: from mout.web.de ([217.72.192.78]:43053 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbfGNRjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 13:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1563125936;
        bh=dYp0KVG4H+rQWC2lfLRDt60u/ZDbHoxqMrs8D4K53wI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gfEBOC/Sk5XKecDH5O1IpRmkwhNgLGi6mvhBo+PeXGuYQYXxZ9CNu39oLVx4MTuou
         5uh7Me02DHRFdMR0vCwpwk+hukgagDz0uaSVL4YtQTaQPbtnPCZztoQoPqlwvbumOJ
         fIzcdryiQJjbmniNeZrR8QvmM2vW7wUXycVlAzGw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.159.144]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWB4X-1hxLa52PH7-00XGwE; Sun, 14
 Jul 2019 19:38:56 +0200
Subject: Re: [v5] staging: most: Delete an error message for a failed memory
 allocation
To:     Keyur Patel <iamkeyur96@gmail.com>, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20190714164126.3159-1-iamkeyur96@gmail.com>
 <20190714172708.5067-1-iamkeyur96@gmail.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <1de4f5d4-fc63-9445-c6b9-fbaaf6d7f200@web.de>
Date:   Sun, 14 Jul 2019 19:38:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190714172708.5067-1-iamkeyur96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4cKPn0vk/p6pOVwCSvgE96Ed7lnmE0pkb59VTn6HOSvWqtanMz6
 Db8C7LMDA975h/j1vAznZT0yY/PMR1ToFhe+DhOGmiXeN8nfHcFm59Flhtbi14hId5zs3sa
 zoYnmLIDVDSAFc8aHJuRaR032FZSa32AshKiRafCL8O1XtO0nr0W/CNvR42Y8ArdqTYtZ0I
 mxROU6K8/CkF4dggt1wNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:668FjLF1rGI=:XdT2Ns+hpVEp/FOTS1w1zV
 w19PQ2eHYt8IZiqpQIR5Q3gUG41JOwr+/pAkDx1UG86bD21NNCihS+Yitrzh7hS7gd/dZk8aR
 6qZDvi0oBvOoz0mK0H5HhW8t4yoWY0st9tr0ota3a8MpjbR84XF0OcKyIxM5J0gvCnUdpkBG8
 h3t56YRHZfTrp4kJf8Au8cbd8eQaA6vpURNe6g9kZeRRhGZ96KWSd7/h2otcGHzgZUcT8+bQC
 +ogS7qZmi+75qRaweM746VVhHnUI5f3bwvT7jSk02nI7PTF++Pd6KzEFWkQ9bCsvjauDO95rr
 PVJf8v5vckjGu3bgJ5TQ0UBC79NGAq9AvDRIQo18DFRGRl0R5pXOaQgplbtbwZ52gwqglGyq8
 RB14O6LAa5ytYEDRb4HNMwytQ0tH6etvs/eJYXOsxjHSxm+caRoeA6VMKHck8QyjBy2rETyvu
 lc6KSiEI+HovfOILUJ/53uNaUvSMv8O9ue4XR/GsqkB9vSos4G47SH/JChDzR6g9ac5tyKJZ8
 rNrwE6YYwuZUD6/5RV2VbMihdUDdywPiTcsuEYl/VuvTQnouHCuXLqB33GJLQmKwNMnSDTF9c
 bIKQT8ZB4C6dQfN/BXmpB0Ns0eGhuXF53nJLnOnfR9lO3CNL/flVxJIWSoejyswmEe4bBDO5S
 baPuirSuv8FOsZU7vStaRYKnMMHCvZZpOngGF6/fCSTigJQ4As7AaDyoiqv5Nm9bTtEK9OjdR
 RYkIuw5Gq+n42k5lfQFXMYDch/KuMn+saGDqdolcL9Z9vhNc0Lh19XnPH8swfF2hh+jsRv0FP
 MSGQPvUCpBRtEG+Ey6JpmZfR9dlu0Mks9SQNm+2aRNhinFT9rNOx/NUZAOu8lcF04xAtzQUv4
 VACMWRP/vdaRWXRdIZG8CLDG6ezeYd5ny+c1PZNbD5FZY/9Thy8cN/zGmUCCxUIovtu/mtcHe
 frZPg5DsrSK8kSOTrx/hl/Ega8d3kgY3/wvus2Ctu7iK53njGs14/grk6zvZfCYNF3weVBlaD
 5cPU1gmF73HRcUGX9Exx0uz5NUcDX47HkkDd4LnHgPSiaHBzT+A0on8PvtQqO/363/0t/aPXC
 ue6Gxha/2726usWQImp5xKpfl4yQ5azMvio
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The kfifo_alloc() failure generates enough information and doesn't need
> to be accompanied by another error statement.

I am curious how the acceptance will evolve for this variant of
another different commit description according to a known software
transformation pattern.


> ---
> Changes in v5:

The subsequent listing should usually be split between V2 till V5
for such a patch change log.

Regards,
Markus
