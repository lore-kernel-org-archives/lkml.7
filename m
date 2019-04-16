Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62D3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E2120821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555415302;
	bh=p6UzzOBzCBfaS0mJIsAp4V1QaN4xVDpgKA5sECjhHCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M5sIQubVNRdBRTXw9mOLGJdDt3JI4G4lqDNjNYSeLWPa5Q0fWdISnkomVQuvv0rLS
	 zBggzozRs8Ih0DFbRMvFiLxs4ixWHpfb6BoA97GbK7v6CSbRyvI44tCsYw/A/ny3zj
	 hbowSjZQIbSyM0aOsAAtttlGVKSbU29K7f01ErQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfDPLsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729364AbfDPLrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:47:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C98420868;
        Tue, 16 Apr 2019 11:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555415250;
        bh=p6UzzOBzCBfaS0mJIsAp4V1QaN4xVDpgKA5sECjhHCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0KRpFQ43YozQaLhvsIuz5TqibmALzxlhcM464OV1zguuHZJRxLYr6wgKSg4h4rK7J
         PDfhUmF35vhsgnJtEku+eNlzmvNKFg2fzNtfztls6oTgjqs8JyMpFfcju+VD97SlWY
         0EKe9umW6gDtXGfhpYErDEapieTtZS+QL/Mf28/k=
Date:   Tue, 16 Apr 2019 13:11:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v10 4/7] dt-bindings: anybus-controller: document
 devicetree binding
Message-ID: <20190416111140.GA27738@kroah.com>
References: <20190409144250.7237-1-TheSven73@gmail.com>
 <20190409144250.7237-5-TheSven73@gmail.com>
 <CAL_JsqJhefb3qmPN4Fn5zMz_UYFTRdPthqi4NNGMNqwNtSy76A@mail.gmail.com>
 <CAGngYiX15ts+dr4MzvtHcEfasZCSK1Lok=PkVhqRwKtzWVnQtA@mail.gmail.com>
 <CAGngYiX+53Rk2gTJ7G0QhQvEL-fF=Zan5jW9h7cR3gV1-J9xCg@mail.gmail.com>
 <CAL_JsqLx1a+rENo7QvF-ZXmpLG9Bf2-AGkTPP7hx+Nr_Uh+NvQ@mail.gmail.com>
 <CAGngYiXOedU=3KRnPVWcqhtP+zOcXtkwAuP_Grucr=Qo6Dj1=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiXOedU=3KRnPVWcqhtP+zOcXtkwAuP_Grucr=Qo6Dj1=Q@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 09:11:03AM -0400, Sven Van Asbroeck wrote:
> On Tue, Apr 9, 2019 at 5:10 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > No. If you send again, then add my R-by if it hasn't changed.
> 
> Thank you.
> 
> Greg, are you able to apply Rob's R-by tag if you merge this set as-is,
> or would you like me to repost as v11 ?

I can add it, thanks.

greg k-h
