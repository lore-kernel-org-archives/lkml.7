Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619DCC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 05:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C481214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 05:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RmtIBX/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfIPFF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 01:05:26 -0400
Received: from ozlabs.org ([203.11.71.1]:47969 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbfIPFF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 01:05:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46WvM64z0cz9sPq;
        Mon, 16 Sep 2019 15:05:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1568610323;
        bh=EQabE8r3HeK1vfzgH3X6IqDqKY3HILHBl4Rvect7M5k=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=RmtIBX/52R4Y2VvxMf6ODCE/t4ODm91Zo4Ex4VWcj1grGHaDcrfns84f9YBMqaRLP
         RmWtzupGaJzZ8jPZZtr/aqJrXN6c5bbKLq1Kb+Xa8gOgEczGfyv6BPiO+/SZOujv9n
         O6hhXwpyEtimyF4vxBrs4pMJ2q08ldNOZHjs7bLiI6vjPW9Stcc32ubyA15Rk+jQSl
         Zs0ILdExqUArE90mohzUseXO7nkEjGtsAcfYNFJI6WdbbOCtBSknbrTOPNiaTUpyty
         pZDogQmFpgUeS/PBTqtzpAlQayzDribLFxZXokNMONGgkwYSio07uQlQb0bzRoSgeI
         Sa5CS9BCDnk4A==
Date:   Mon, 16 Sep 2019 06:05:14 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20190916013727.GT4352@sirena.co.uk>
References: <20190905160237.2e972a89@canb.auug.org.au> <20190916013727.GT4352@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: linux-next: no release today
To:     Mark Brown <broonie@kernel.org>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <D081BA7D-9074-441A-B6C3-A742B41FF111@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 September 2019 2:37:27 am GMT+01:00, Mark Brown <broonie@kernel=2Eorg=
> wrote:
>On Thu, Sep 05, 2019 at 04:02:37PM +1000, Stephen Rothwell wrote:
>
>> As I said yesterday, there will be no release today, or any day until
>> September 30=2E
>
>I'm going to try to provide some builds for this week (16th-20th)=2E
>There may also be a build for the 15th depending on how much rebuilding
>the rest of the trees is needed for the build I've got ongoing=2E

Hi Mark,

Thanks for this=2E  Don't stress too much, it should ease off a bit when L=
inus
starts merging trees=2E

Cheers,
Stephen Rothwell=20
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
