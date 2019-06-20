Return-Path: <SRS0=cuNS=UT=gmail.com=dioufcrystal@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C7CC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:10:53 +0000 (UTC)
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF7520652
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 20:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="davAemE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF7520652
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=dioufcrystal@gmail.com
Received: by mail-lj1-f196.google.com with SMTP id s21so3876830lji.8
        for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BaVfrOkjb8G8ibWdoeJt5uL4kL2uCYuQndDiF46PGCQ=;
        b=davAemE0aEzEDt0tlTnaI8ECwz/Ngv2T1DpLXsFSeHFPcKrrMKPMFjBqKjE0H2mKxJ
         +hKU8t/GtUPhNu+K5S7HXTkMSyZGmzVDlp3oWM8sFCav4HS9b6gQkyOtUPggApATNsTE
         Z5yq4qYh5ZNsCsolhgTZHNEvlD0yLVLLgmjoUlnswG2xBsleJ3rAnkvJcFL2TrGjLYdF
         YSdkcSSQzw+hW4quOWHRX0Fq65ZqWTuihSAkyCWnOnV0mL+lg/rI2M/1qiivgPF05ZHe
         6jH0Co3mi51t0Pvz4zXC3uS6c3dHZPbGT7xpoGugQjuutdCT0ukeEWFNuYfOspakTXu+
         Ypww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BaVfrOkjb8G8ibWdoeJt5uL4kL2uCYuQndDiF46PGCQ=;
        b=H48SfX2qkK8+58yOgTRTi1rZFsiF6f8yCO3exefKE3U5Fn5tf5z/ZDY6WgSQZjg9Ry
         NY01jMAIYo8hhAsHox7fZtnNL7zUXBY7sWtFN5Nl7Am6vnDrfDBmILu37Hc0YiBlBpZO
         YxDPpPfyj+540xzTx9x7MKdDz+VDzQcxYeRqavspAWzfphug0XiDPg/8VaVKQm/oqCOu
         +JSw5coqD4Y5rbjP7M5H4hyRYJuQKLeLwcYgZfLhwJA6ClTOKB8ocJsvnSOKoi0kKKce
         urdPYfmQBUuW6ul7PYVLQ/uyGj8QozDL+G0Dq4kuvNL4uXB08zkh4dqhtdtiYLgiRQZt
         7BgQ==
X-Gm-Message-State: APjAAAXo5Cbk+M0pzI90FsYXI47DFKf8hg/wos0A+B/iAvmTcpSkV8H5
	P37ZkZqCRTx210jJIkjwVmAauBUiCzZGMVVIXgEVFwQA1y/8KQ==
X-Google-Smtp-Source: APXvYqxmLDfAbOBDeFNpKm00Wt0kVt6WL4Z+v0Zya8s1HkwM4pOVx8G0OCL5a9RlJ6Jonvn5U/UFI5Q+gKWfCUPzp/k=
X-Received: by 2002:a2e:5c88:: with SMTP id q130mr42741513ljb.176.1561061450956;
 Thu, 20 Jun 2019 13:10:50 -0700 (PDT)
MIME-Version: 1.0
From: crystal Diouf <dioufcrystal@gmail.com>
Date: Thu, 20 Jun 2019 21:10:43 +0100
Message-ID: <CAHWcrVdDOnvROV_SDo57Bp+roudL4-BOppBD7hTQFPH7+HthXw@mail.gmail.com>
Subject: Hello
To: linux-kernel@archiver.kernel.org
Content-Type: multipart/alternative; boundary="00000000000041c4ed058bc6f141"
List-Id: <linux-kernel.vger.kernel.org>

--00000000000041c4ed058bc6f141
Content-Type: text/plain; charset="UTF-8"

 How are you doing and life with you in general,

--00000000000041c4ed058bc6f141
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br></div><div><br></div><div>=C2=A0=
How are you doing and life with you in general,</div></div></div>

--00000000000041c4ed058bc6f141--
