Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0259C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B482089E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MSAx+ogl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732944AbfHOSel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:34:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:48305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730867AbfHOSel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565894066;
        bh=+2oonmagg4vxfNFfRbEmDPibIdyxVmitLgc60Mm0X5k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MSAx+ogl0gftfHW1BIAJ1/IFdXdQ0gK9ydf0+kJWc2FtMpx1HWpbTQ8NASDzBgYAg
         +geBVmow8KWC9N02Bf/dA7MSy76aPqzK+olpc6eJgHYYJNAcX5izUW/6Y5UHZEUv+b
         Q4/jOPhT9KWF7MdlYccvDOFf4yhDnIy1MvfWx0Y4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.106]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MIdif-1i1Khr209N-00EbPV; Thu, 15 Aug 2019 20:34:26 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 2/3] bcm2835-defconfig-next-2019-08-15
Date:   Thu, 15 Aug 2019 20:34:02 +0200
Message-Id: <1565894043-5249-2-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565894043-5249-1-git-send-email-wahrenst@gmx.net>
References: <1565894043-5249-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:pgYfzagC2IHOaULxCptjMluA3Bu2jXR1/IqGOQcWRLxCnf+GbYW
 +oZOSfYhJwPq+poHXPY3Hz37KV1d/BB3WLtkHfpHL2E8773oJMDhFHBNi4p36jd7Yw8Mqgy
 b2IA4xL28luSgWWkenBEyiWtiaz8gxNGdMyb35UXdCoY5Of6dmn0vQ9ugycIMyUwyFBXj7T
 KD84i48STPVi/BI8fXg9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YH2EV89Ie1M=:XnvyZlsxLzaEAqtKiIPEmD
 gPzgQiYE2mpHxkVrvVeqHxpSQyZdTFZcb4V0KYdlOX/bsVFIi7aORjRIrW4JE5C5zs+rp8HtD
 WgRIaGvPtdBmHs1YyU8341EMrynyhAn5dwTsBn8HuHxhjil22PCMajt/5BRnvT/rV9lMuHXq5
 ux/hpFEUA9UpQ1RuE/PU5biVH9O2dOLk7lYtz/ihU8pV+CNbiclZUkHRtkInqSlUHuEQ1tqFU
 ZV+um0CHj2BZWtAS6oqoWLYZFm2NzwT1VYHWIf2XsjTKVaTNyhMXatabHKdr3VcRJrMZ18F5S
 8a3zYm5B3EMwkqGIgooLs3w97tZq0bCVTekDp+w3MPBxS/RbRifZjBfc6iBM8s4hPaL8KqByw
 jUbuyUYM3llnUV7AQJohbKA26fCC9kMJ1oHrNeR12V9+nbwoENHE112P2T+IKi5YjbjLANDpI
 9IJL7ndm7ZNJhEsB+i1d/66DiFQkzWxLbbARJ3v3+ZpBLbysVremttnsCa2sfgjnWVZSIXXxK
 wTXOsBRkuifa2ED2MBEyolvBNh1Ka2WpD5FKeYYfptuxv1beDB6O4yO5Ht5lMyQvcN0pCDM9P
 VpJKU51xwVp1t5oCc6+j1ptEpbCI4IcqZgv8F5pgg1H75MxbmXeveHhdjaS2ZKrrQb0+D9otr
 oYzaBVZG1WW19m0e71bmCZguY0+o6DElrsuW9OECVbcDuXdI1uIUSn5iW9tIHTWBN+DwbEPjt
 SYZwxBOXj4Uv7Xmi/IlwN4ZTmH+MXNJTuekrHe0mL1dfrFMi9Uey75q+BCeSbTAa33W3+3Dfr
 gf+0bE6wCQg+1SSHxVsDgyBHMeqxFsPNdaRGUFmoSs/pHajN0nLQJJ0B7J+bnR2WGYLpLQJ9i
 +062Vz8n7lWTQctcG1HY6CuzqdcAaqZmGnYMz9OT4wiUwbSO4M8h4fVhDBMTQhhpdXE4hZKKU
 dqJzFEPiLDQFGBLk363s4bFLCIFLBQ9vxV1mDIoTlRVseHmBtv90yz3Wb3sGarhGhtZsCnGHf
 eqaeZXN/ydpyPEUcOLPb1yUsF1jMoq6NvLvz7kHCcT/tEPm0UnIbqZiXP48YlhPG4YZ8EfDvl
 r/S7EFLTsaUA8vfs19J6qQwIOUcwaOKLheR/bydcxT00nyK/oWfGbukkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-defconfig-next-2019-08-15

for you to fetch changes up to 4c6f5d4038af2c7332630bdd75cfdc0309e97242:

  ARM: defconfig: enable cpufreq driver for RPi (2019-07-23 22:53:35 +0200)

----------------------------------------------------------------
This pull request enables the new RPi cpufreq driver in the 32-bit
defconfigs.

----------------------------------------------------------------
Nicolas Saenz Julienne (1):
      ARM: defconfig: enable cpufreq driver for RPi

 arch/arm/configs/bcm2835_defconfig  | 9 +++++++++
 arch/arm/configs/multi_v7_defconfig | 2 ++
 2 files changed, 11 insertions(+)
