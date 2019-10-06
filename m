Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1411FC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 07:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F342087E
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 07:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570347019;
	bh=o2oRi+v2tANAFGZ+liBCnnpn2Juw9vAh8Vep/Ky/EWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fHxb0ykSPUGD+9eZhJ7SzvmglfAfqg/ubywaS9TpjdMonwxFKvirjADysmJK29RCn
	 Pa1CqkzW2NipcyJDRfkGeeZ01n6oRlmllRz9HEHsl7Ey57Mwd5y9w9ok1fs4MFydC3
	 RUE6x2RUXPk4kg/z60Q2Y3RN+BYcmrxTwp3ujDAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfJFHaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 03:30:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfJFHaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 03:30:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A718B20835;
        Sun,  6 Oct 2019 07:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570347018;
        bh=o2oRi+v2tANAFGZ+liBCnnpn2Juw9vAh8Vep/Ky/EWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEnevVVzWB+o8BpPpJNZtP1LkrKDMAk5txnLgbmNPUU6G23ee6tIIWrbOGM6qMNbi
         /xsaw4YAPwUI4TxWcBOVSI5G3rsUEWy+qJDUiRF9qJTAttRk+mLHo7vL9lYhLpUNeP
         Z8KkNUzs/KvNI+LlDdHD2LB8yAPNpyks3pZpRA/A=
Date:   Sun, 6 Oct 2019 09:30:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Jessica Yu <jeyu@kernel.org>,
        Martijn Coenen <maco@android.com>,
        Matthias =?iso-8859-1?Q?M=E4nnich?= <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [RFC] scripts: Fix coccicheck failed
Message-ID: <20191006073016.GA2133217@kroah.com>
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <21684307-d05c-1856-c849-95436aedeb86@web.de>
 <alpine.DEB.2.21.1910051425050.2653@hadrien>
 <f64fc086-7852-b074-6247-108b753dc272@web.de>
 <alpine.DEB.2.21.1910060727580.4623@hadrien>
 <8390d1f8-1907-ef19-c527-6bdb380d96c9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8390d1f8-1907-ef19-c527-6bdb380d96c9@web.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 07:34:49AM +0200, Markus Elfring wrote:
> >> Would you like to increase your software development attention for
> >> efficient system configuration on this issue?
> >
> > No.
> 
> Thanks for this information.
> 
> I am still curious if other contributors will care more for this aspect.

No.  Please stop.

greg k-h
