Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9A1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7BE2186A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552822243;
	bh=iEcJ2VJxlfxGENNKgBjQYclG6pAxx3hmhnu0woJwYEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dq8SM0M+2YtRwuSaLPzPvvPky532j68q8uyoCPVY1QV/mJd2FGnmBdD3UELUNnix1
	 X8Sn2h91Ul2wu05r71WO5Rw34VBs71rMlcdotODDZ9nL2s3+rp7XfvEhQuFYdpRKwI
	 qa1oRYmRT4oycICe+DDJl64vMP6n4LXhpy6uyY8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfCQLal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfCQLal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:30:41 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A6E2064A;
        Sun, 17 Mar 2019 11:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552822241;
        bh=iEcJ2VJxlfxGENNKgBjQYclG6pAxx3hmhnu0woJwYEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Knbx/GX4gPGuNjjf+zG9dX4YbYLQEEphbjOzyD4C2D/JQfi8MuoZE9et3TXtHqGb9
         6OtLQI+IohDesMLZaStGfmDIZkOY7sArAsgQhK0y9KbOq/tCCyCy5Yaq3O0VbL1DQt
         LFU+8qyo3AE6BGnaa00WBW+XJD5U7yq2o58P4VJ4=
Date:   Sun, 17 Mar 2019 12:30:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Emanuel Bennici <benniciemanuel78@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: vc04_services: Add spaces around Operators
Message-ID: <20190317113038.GL4614@kroah.com>
References: <20190317015902.GA1553@p200300EEEE2F.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190317015902.GA1553@p200300EEEE2F.fritz.box>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 02:59:05AM +0100, Emanuel Bennici wrote:
> Fix Check from the checkpatch.pl Script
> `CHECK: spaces preferred around that`
> in vchi.h

You also did something else here :(

Please fix up and resend.

thanks,

greg k-h
