Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829F0ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3D620854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DhcKGzun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfJORQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:16:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:36675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727243AbfJORQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571159777;
        bh=AhHV6TtMeciM0Gr7rafl85fPJjF0rdTKI+ZYNxJSWBg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DhcKGzunTjcm9phucq+nqCWKy7F3/HAW3E3NyySjTox3ej3RoeEqodSxorFRrjaA/
         EmfzUj0RP103UkvnjMyUbdgsYR7OHRyRbDRaEsoXhu8u8MwJYTov6RYUgVSYQZoS4f
         AWIdA7Dg/LAIdo+vKSxHgcIhDKAfyKfOPA0AKKb8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.112]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N6bk4-1hznqQ3RqI-0183KC; Tue, 15 Oct 2019 19:16:16 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 3/3] bcm2835-maintainers-next-2019-10-15
Date:   Tue, 15 Oct 2019 19:15:25 +0200
Message-Id: <1571159725-5090-3-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571159725-5090-1-git-send-email-wahrenst@gmx.net>
References: <1571159725-5090-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:01i+QbX6mSH342HD8rtrSxzRjRTt1foLS4W1KCeunXXHNi7IR9E
 FrYoU6wlK6tfFfxtGVgg0q4hu1rksgNMxoa7yVdkub9JXUQNU3cSc4KD0RxeoLBbNqrbV5u
 kOExPTZUI1fQqo1mh366ctpM5PxbIYKxqD9rv5Z3DZVGjLh9QIWP77m5TcdvVjNzOw8MWdH
 UvJl2I7kmknMCXj0Hs2hA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2LPRL9G1FG4=:QAAqQLCA/mJeESN9JBvJDm
 5cQSqJUKQXRw5XqAgGFmwWfckiYxojVS6c0NgeAkka/I1ik1O29d88EM64gNMGbksoT5eroAn
 QH3NeIn7w3Wd2a40uauFemrSBOi8XTri67lWoInmJP86s8uoNmwTobkTe7qNKtOmHW2ydgkff
 SysBT9IEqrWMSWiwD16fcgCDYpeYwFgiYHBn1rWNByh8vaN/MD62MQ73FOLu9ezFiAyMZ/lh3
 BePKYEVGprapXJTIUDQsR2E+ICADHy0CK5o5OoMjBjAFbHlDbY6JQjCMgAuvDyScUtDnfleUZ
 6y1KBCUxHVYK3fqkz3+VnPHOH7jaP+Zrh2nHWIPTTtZx0pR77pR5mXkG662TZcm2qWupNFQfS
 Vwt6X185mAsyO7SfDUFbNnt5yjqOdr+HVxCsTcAGbvxM1ANbcipx1ecTasDRz4p/2VHzTnTDU
 nzeuOOJCecSh681qKiHZ9o71fkPA3eB8+Yt4dE1bYhbyJ9HDL4gSpQzVhQ/H+zojVggXn+0Km
 8nTw9FQ4wTGCvoZREpRb/Z02fZKI4T+4m1Jukpapd3XKPdfrU3/KuSbrQ+/5UIAKtuVsg5xHQ
 v9NI75r36y7IPQlLpccdJH0bz9PxFpn3P5oTMiQyGeujz5XC4r81nF7Q/+FkENKYtQO7aJP/L
 NB+99ESKVoyINCb6KjscI5Aslaa71FFi/ZYEW8PJq/WIcP2EkYyDbMnZReu5vpHeb01ft/SHv
 FkTZABIe4Etyv+4RGC3SBDyHYi6yZf04E0KfiDEwYT9BTW0f8afV2ULXd2PwLrzQ9yiW6+yJh
 1I9DZF84DPd1yCW7mnozEJZ4J3pF+3bhBEM3Fex69AOM0hQMqFdWJ/P0MRv3z/Uutk+zqFte4
 ctH7jLC6vQCaJHwyaPiUu92MZofpr9vM3Q7K1/bnE5toXV1pSf0Sjbjc+ATZFroZC/meo+zvf
 H2fEfrOdwVvrtybbBZ0oWmiD/KdBfaC1vM03JA5Aa7KzR6Sf49XEAU0yVsLehSbFatzj4aTCf
 BpF/Yo+RBzZW4uhafbuqLxBQzSQLp7kqtyTCmeOH+2JEE95PJ6DoSrsIkKHDIhn13A1pFyevm
 98ZSpV57StIhkuf3cUIzrW/UZZhq5Lhu9Oq9fncgyt7G3ayw5mOi/sRTpKfIKJwjzhoMqKTwn
 29rfbf/RYjAgsI0joKIwfK5PYIAY6Dckmv9xcM55mC4SbcyhzfzTPuyhobTN6HmMgCYRfFh5L
 z2ifUP40fy7k6oA1ueW1P2l7b0FN2/yDzfIdIZg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-maintainers-next-2019-10-15

for you to fetch changes up to a91f757bda1a48317f692487addf832ebf8e93aa:

  mailmap: Add Simon Arlott (replacement for expired email address) (2019-10-12 12:48:25 +0200)

----------------------------------------------------------------
This pull request clarifies maintainership of the BCM2711 and adds a replacement
mail address for a former contributor.

----------------------------------------------------------------
Simon Arlott (1):
      mailmap: Add Simon Arlott (replacement for expired email address)

Stefan Wahren (1):
      MAINTAINERS: Add BCM2711 to BCM2835 ARCH

 .mailmap    | 1 +
 MAINTAINERS | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)
