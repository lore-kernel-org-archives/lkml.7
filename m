Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D87FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 05:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA0020700
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 05:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552888759;
	bh=2OHqeb8dRoPu1gwZpFHyPbay6SLmWnXesGXHIopE2/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BIEy5QPJiO+Hhmre9H9HNbX+LakWqaIUQdSRZqYFPjt5Z215ZjOmvWRz86ssTFypQ
	 WQBXU/fPueRX9xpwWAeaPbbiCJDiCpAG/AbXEQq2ZzHlx0mRwa/rbZdnhNmgbjudmS
	 Sgxu6+70K2mibeUBoIP/RiThlnUx43TGRIJ+9uN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfCRF7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 01:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbfCRF7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 01:59:16 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C8920700;
        Mon, 18 Mar 2019 05:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552888232;
        bh=2OHqeb8dRoPu1gwZpFHyPbay6SLmWnXesGXHIopE2/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eF1zevv1GzJF9b7h6IJLPJgRLZGJuxCBpVHGDo9nP4tmf0CNo4x2cEQsjMFVaB4/G
         LkdYh6mupYXJT8CLuJu1SgfYSkal9LxiVx9RBIb2cVQOCedM3p2xcVkm/TT/eBv47v
         f1VXJ6CFer7FJcUyBmrKuYVZK1T1n/uR0PinRLbs=
Date:   Mon, 18 Mar 2019 06:50:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ignacio Losiggio <iglosiggio@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ignacio Losiggio <iglosiggio@dc.uba.ar>
Subject: Re: [PATCH v2 1/2] staging: gdm724x: Clean long function calls
Message-ID: <20190318055029.GA5323@kroah.com>
References: <20190318011534.7400-1-iglosiggio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318011534.7400-1-iglosiggio@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 10:15:34PM -0300, Ignacio Losiggio wrote:
> Signed-off-by: Ignacio Losiggio <iglosiggio@dc.uba.ar>
> ---
>  drivers/staging/gdm724x/gdm_mux.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)

I can not take patches without any changelog text, sorry.

greg k-h
