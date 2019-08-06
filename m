Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E815C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60C720B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 12:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1mpAMGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfHFM5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 08:57:11 -0400
Received: from mail-yb1-f170.google.com ([209.85.219.170]:40328 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfHFM5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 08:57:11 -0400
Received: by mail-yb1-f170.google.com with SMTP id j6so366163ybm.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 05:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=A+Df6wXlvgK8D9oUccwlHPkZ8Lxe4ieN2VNi+kgVV/k=;
        b=H1mpAMGwlSlkVK0VpJp8SnoEF/1zh5eNEiIkkeOtsnTA9lCx/c9ldJHcY3zqqadkMC
         tC+f5LKlkEW33LFrXPLH7/Cj7pktXSBPpm/QWj69wVoQMD13fQZ3e2hR50LWuCM/qegs
         SdV4sNY0O/5EzOjY9/8Idi6OtBSejK19nUeqqmzqUlZ3Yu2wZjf9vZD6nBEmWL6slFd9
         5mxm/E8aYObyZfZ9Z/pExMkQW5aPgPITsWc4KKV9veCHkAF0z/TYH4WizpCD5+yhxjXM
         ZRarUKeeUaYm5OGv7KYZxO7qC+RIqSvV74X9m8/zumv9E+u/dvIhbL+i/QAE38XuJzyu
         +dJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=A+Df6wXlvgK8D9oUccwlHPkZ8Lxe4ieN2VNi+kgVV/k=;
        b=OEx4LIvMy3vFXZm728ppWCEiX/HQ2BtT+E5QlYJDqVWVRt9HITFyx76CLupZ4tfl4y
         Xq+M7DPM/rO0tXXPBGARtxgBuTk1ze8wm/KDWohBr0o54Ioom/5OGknOioujXreiCnpa
         JLAYFdymaCMeIGj3Wsx4xf86Adxdgcxv3n140QPCyy+kgMNoge/9CsgreI92bjj944V1
         bp/T8c77wh33ErlD8zPFRTWLwEDoho6fLeAfIHbVBRJpO3pqarVfMmTCtz7IKDI5qZVs
         Fy7uqbwclJWI/mxZENqgM3Vo8YVy0Rf/lIS76o1NEerGmc2yiTLYFRP2N2JHlU0UZfHr
         3aRQ==
X-Gm-Message-State: APjAAAUR3G2k+ACkUN6MSbK/ZWQhFYOwMH/i6wlW83wXulLG4SuuFmqV
        Qnbe/j+mAcRTYCQoFfCeWdQlY58a0Wd851Eg9CTP8f8=
X-Google-Smtp-Source: APXvYqx/HoBeqAVoPC23A32qo+zFldUW0H1MYS+stX89XYbvsC6/SdXSfEkGx3RLuGo6qbqZMF7JW+K5UQ1O7bdA6+I=
X-Received: by 2002:a25:cf8c:: with SMTP id f134mr273220ybg.55.1565096230209;
 Tue, 06 Aug 2019 05:57:10 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Date:   Tue, 6 Aug 2019 20:56:57 +0800
Message-ID: <CANnei0Hmkyb1Zq+X1vP7QMV2-d89ON1R+pj2sRFfhj0ErrcwJw@mail.gmail.com>
Subject: What are the differences between cointelpro, coamdpro and convidiapro?
To:     linux-kernel@vger.kernel.org
Cc:     Turritopsis Dohrnii Teo En Ming <tdteoenming@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening from SINGAPORE,

What are the differences between cointelpro, coamdpro and convidiapro?

Thank you.

-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
