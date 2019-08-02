Return-Path: <SRS0=wpmy=V6=gmail.com=synthiarichard724@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F0AC0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:55:01 +0000 (UTC)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500A0206C1
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVxl9Fx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500A0206C1
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=synthiarichard724@gmail.com
Received: by mail-wr1-f66.google.com with SMTP id x1so28868948wrr.9
        for <linux-kernel@archiver.kernel.org>; Fri, 02 Aug 2019 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=jN9E7VgaCXVDoOCSLEyjmPf22aPkrwrqr4+2hcjy4Qc=;
        b=PVxl9Fx6fyHKze/RlgMKtGboOVR//nBvpXKMr8ONV57CIiOBW0TLJedij8m+Yfd/Iz
         F30A2pPX6Ua3Zv9pw4HaIKcGHCgZHeyenyUJgo13b7SHeupdqeZ3taayioEizCaTOWYq
         a9IymGBpZI/qo41/yyMUIZlcOB0E054Wv1xq0zTyq81Ewu4ytrjcq2P/2/k0/W0M/lfw
         HCdhjfZvI8h0z9I5bJjtnDrAeOexXGMnNWd428xSSOFTtS3PXHWreq5mty/UyVgtuRNN
         vpOxSqAhyKSrkjGIPbrNzLHQohixAA8Q/i7oL8QaO9SF+yYJdmyNetgZ9PQ2taIJRN3E
         b+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jN9E7VgaCXVDoOCSLEyjmPf22aPkrwrqr4+2hcjy4Qc=;
        b=dpqlIIt2ag0dx48lS4M7WkVkgf38geu0CeJ9so70j4rQQNz1Zi0jxYBjgSVH4GfM8m
         GYzPa13j+vPYIXXkJDzWGah90rcrYaxjAqaaDuuExcopORG7SKUrfZxjoJb6DSt70jtQ
         uOmBQjBkN+g1yPnp84phPPvGvhn9LfBZhyuvARoDKpbwWI4J6BFRPgYRFt5IwKFdXds6
         5p0JMwA2eMLuTtbK27lBhZjFOD8xK9mOuHomVn3/0hTvginQDknKLv/Jvf3R0o6GRsp5
         6p/byC6Pyfzzew25CE7Jmdj6dYXIo19oxsdzeSeM8oJDBkQZv6+7RZsVHWdDpBBmxH4F
         BDJg==
X-Gm-Message-State: APjAAAUJeOpsmEf8PSv2amUOvvw8LH81v33oIPzWZ4e5wz0PpW2KLKm7
	FZWXKOxzT1mKna0puxMPsCDidIGvS49lmsToOjU=
X-Google-Smtp-Source: APXvYqzOxARP2LYhRh5+dfxRSlMT0yz06WEmTyGTCSLE589iDINMR169vF2m/iAckpWlnpm6Ok0FXY6U62HTPjPlEIc=
X-Received: by 2002:a5d:4211:: with SMTP id n17mr73503191wrq.137.1564790099883;
 Fri, 02 Aug 2019 16:54:59 -0700 (PDT)
MIME-Version: 1.0
From: Crystal Diouf <dioufcrystal@gmail.com>
Date: Sat, 3 Aug 2019 00:54:49 +0100
Message-ID: <CAGBVJuBT8Qgxq3kh7BGGtf5UWodqo+7hfXgBPpOiAxv-P6aUaw@mail.gmail.com>
Subject: Hi
To: madcatsxter@gmail.com
Cc: linux-arm@overkiz.com, linux-kernel@archiver.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxaudio@showlabor.de, 
	liwanp@linux.vnet.ibm.com, ljalvs@gmail.com, lorenzo.bianconi83@gmail.com, 
	luciarosculete@gmail.com
Content-Type: multipart/alternative; boundary="0000000000000d3b82058f2b16d0"
List-Id: <linux-kernel.vger.kernel.org>

--0000000000000d3b82058f2b16d0
Content-Type: text/plain; charset="UTF-8"

-- 
I am crystal Diouf From USA

--0000000000000d3b82058f2b16d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" c=
lass=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr=
"><div>I am crystal Diouf From USA=C2=A0<br></div></div></div></div>

--0000000000000d3b82058f2b16d0--
