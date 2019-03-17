Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276F4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F0A2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552822115;
	bh=/YjfzvtXkgQLGEPmUC3++CGKXOsuoElj8iTI8ktj+pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fob5hoPwuqb/jVecT9KUyhyyTfi5FChP9dEO0vsYXGPsxluW8S4Yk7290oeDOO1oB
	 WOAhua+vb18uorXf9trmaWKST5mTye7+q0lTBeCsfSK1ItI2tCgkd2tb8KgiyrtYuG
	 Pa2M2s87y0Exro5Tf2NQAOedKpWVpeuO2lwcP8VE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfCQL2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfCQL2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:28:32 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8282085A;
        Sun, 17 Mar 2019 11:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552822112;
        bh=/YjfzvtXkgQLGEPmUC3++CGKXOsuoElj8iTI8ktj+pI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCCCW2pCH2bVpHnGeqLrXhz2C0yoPoiooT6SqYuiThoW15tKvz64qAaAYSr6OSO6P
         bkTY44euLhE5fg0RqkB7rhmqTJsZbayChwLxcl97QIkTI5trkJnuLTR0+01hEwYBuR
         Vm6hFeGADtd774rCTjQ1r92YDYZdrEdP4ivd5K94=
Date:   Sun, 17 Mar 2019 12:28:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: do not use __constant_cpu_to_le16
Message-ID: <20190317112829.GI4614@kroah.com>
References: <20190314083155.23164-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314083155.23164-1-sergey.senozhatsky@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 05:31:55PM +0900, Sergey Senozhatsky wrote:
> A trivial patch.

No need to put this in the changelog text at all.

Please fix up and resend.

thanks,

greg k-h
