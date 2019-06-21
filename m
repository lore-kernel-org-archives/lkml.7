Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103D7C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D810721537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561124926;
	bh=rI3c1BOmsczqHXJN6hvv4bgjJQdjsSyfRhzndKaR1so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RfAcEfrq/nT8ZUjjV9L3j49JQqL74Jb5Wc5A8Puj8v43ZFoXyLLMffBD+80zdsSu9
	 2ucXnMgMV/AjvZ6JJ0LUxPSJL8cKZ59ys9POFBL8zNDv7aUTfEna76EDxyFgMRsV3e
	 cezzNeCPosvK+VvG5TRN0OR3kjlOVv0lha4KqYf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfFUNsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfFUNsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:48:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED744206B7;
        Fri, 21 Jun 2019 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561124924;
        bh=rI3c1BOmsczqHXJN6hvv4bgjJQdjsSyfRhzndKaR1so=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1f2JM+sOwZwawmkvWu37ujbWtD2T1HlcBG9j72f0CLmpgLBRpmjvQteXZQPHxpgS5
         CsqGEbTjAp8Kd3J/r34AAQw+XRAwXwaiOE3LR1IU9K+YEdJz5nln8wdejeqNARO8Pd
         lZrvKScl8baWWKF4m7thzkL80KUkCtRjHfFFNgE0=
Date:   Fri, 21 Jun 2019 15:48:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jslaby@suse.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 06/29] docs: console.txt: convert docs to ReST and
 rename to *.rst
Message-ID: <20190621134841.GA26766@kroah.com>
References: <cover.1560890800.git.mchehab+samsung@kernel.org>
 <00ddb1bc19e07b7ce4d1e7cda457733a37cf1693.1560890800.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ddb1bc19e07b7ce4d1e7cda457733a37cf1693.1560890800.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 05:53:24PM -0300, Mauro Carvalho Chehab wrote:
> Convert this small file to ReST in preparation for adding it to
> the driver-api book.
> 
> While this is not part of the driver-api book, mark it as
> :orphan:, in order to avoid build warnings.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
