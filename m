Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A250AC742BD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D9A2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kcHASYf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfGLPAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:00:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:48129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfGLPAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562943623;
        bh=E5cL1bdBi7a0hqmLo72Y0yY6avSwPZxLDmGyrFDF+rM=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=kcHASYf0slvMpNRcoLpgK8wnPGebUWVk81a0ULw8oRfRI83YS3AC0gCJcwEZfPvEh
         d69WCd8gyiASZNoEewlcq1JAZ7dnHS0R/Aj97/TQnNxAsa+b2jFzCDuDgmTa9jfhxx
         mAJhgyH/7Q0zhUmo1UsT02tvo8yAXKV+u2TZsN1I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.18] ([82.19.195.159]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MfSrf-1i6fmf3S4B-00P8el; Fri, 12
 Jul 2019 17:00:23 +0200
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
From:   Alex Dewar <alex.dewar@gmx.co.uk>
Subject: Asus C101P Chromeboot fails to boot with Linux 5.2
Message-ID: <59042b09-7651-be1d-347f-0dc4aa02a91b@gmx.co.uk>
Date:   Fri, 12 Jul 2019 16:00:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:0Ig0jVjRxe82w57gZlwVZDbQhcIXSbWNt1DJ4hbetT0Cc1lQvdN
 b8ALJ7W2IYaz46I3cf/12PmcWQ/7SGlAa0ShLyqFhBW67ahXPawI+LQZEhtnfU3cEhmlnOu
 opUytUCQnokiowehD30do+knYTo1+CobXIv9Y+N4tip4oLVxTWdelYH+LaOLPLgWwMRXq5w
 8WvaCt9acPAHJv7e5Br3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iK463nS1Ddc=:SRGGTrQxn61hEBHrYiQOSa
 gKJtlJ0rvZ8QJtcIhOx2M62tukG3amv1jueXOZgdWX2vjNFT/f9s7nzZM4tXQ//Z24tMyRB1Q
 ADJuBxmIcSYB3rDQWLhk4z9DxOczCRwTQ4aJ2rZeP3cLxDbWrX3/VLYvNuJzIAwAtKvk4jAnc
 mjTI/tU12DFMC5cKPt/D/K6G+YkXBIkhCaYygZrphMoculRbnmQHwmlRGdtbzzy75YbAtT2jh
 pQIiRhIqFCBoMpKk76fGPfPzXp2GdIrMREuXDjX5K0bIdV/p833+lkUAz0fPv25Htxzc36k4+
 uElhJS0qIePhKAKgzSl9yeWzh268dcKLfAFbJ6rGuhQ7OBmHsIuThKXqhzSrVIqHdcwErrR93
 Ypkgcw0LzpGZSNN1lTI7BL8bdMiDWABtQblbt7n05c9NhV8cHMHW38eZXISDIgoukm0LFT/MM
 uwf43X1nx2YEY7mqwfuD9ZjTHQYFEn3vO6vDZV3c1t4g/BsO3kQXrcIUJn+xs0BPGLYodcGdf
 sXdxQg/KpzEkjGSGKeGg87O+QARGB53+JPjqI/TL/eBDxOa3xBklefJoSYCo5kMCoGwLOcvr1
 QHQCDty/elvvQ45z0cQLF1D8sTEXYTKX/gDFIpwxzBLJ9jBfR3d52msEV8f1b+7C33ncLuuow
 7iBFCMkx/l84ZC1gWaPauKqE6t21ymeS+mE0pwIx36O42EEdlHmObJcTD7c0LyzCdr123jr3/
 O0kYtq9y2PnFBpO5iBYqhACuaKQ5eYhKeucSwbpXyev8pjdGllgJMWEhrA5ZOhDb8rRSPdCiv
 jOHcypjgYZ2wCjErC9c0oZp+OBxtjNfobZvsbrzMjet0fJtq18OPlzN9prqRD8pQw74o/IaGb
 Ut0pKBT4IzAKk1zW0qraIGM08jWlh8wChB0ccPHmi30s2DAmcgDsCKxR4WR7L+xVPnfGFOaxa
 DANqN69dgeeStiFdk1jwZ/Cqepf9dYDYPQdLs6GuCELiAoDNj6ds64CNhcgTyfVgYp4bA1v1N
 M0gx2sapfEMvBRz9fNE3hdL3iIm3G0A8Da+htGH9IlW73ilkH2fy27OgS2En5RiZHeIimr3wu
 8ADicS0W2tHQ3KOQKvTgD/hoDe814ZSxiGg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Since upgrading to the 5.2 kernel, my Chromebook is failing to boot. The
Asus C101P is based on the RK3399 SoC and uses the rk3399-gru-bob device
tree. It used to boot with the 5.1 kernel and mostly worked, with the
exception of broken suspend and resume.

When I try to boot the screen just gets flooded with messages like this:
http://users.sussex.ac.uk/~ad374/boot_fail.jpg

I'm using Arch Linux ARM's linux-aarch64 package, source here:
https://archlinuxarm.org/packages/aarch64/linux-aarch64/files/PKGBUILD

Best,
Alex
