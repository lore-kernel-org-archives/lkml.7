Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C72C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 07:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16784218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 07:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569742023;
	bh=T5Lor7/oHgnBdsjmK0EWQYJljVBiz2JECMy9Sp8pAyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wxhf9DelK5K8pOgBl8Pz8JBZ04MDkFYxBh5u+QCTLAMC8vmw6bDKS1bmAkIrGRYmb
	 JoXKHFHHrhCwLuCFZSTSPLTRLHm3tZXqs++7LiQ/5l8mGzo1+swGHRy5E76T8r9mbY
	 vo+PBeZOhkFJ2MUBjUhX87drzLEuomLyowfjdppI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfI2H1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 03:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfI2H1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 03:27:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 571AC2086A;
        Sun, 29 Sep 2019 07:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569742020;
        bh=T5Lor7/oHgnBdsjmK0EWQYJljVBiz2JECMy9Sp8pAyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FiEwX4LeSQarvTfvjBP4aXOh2ZIkg+NnHnMbD+nvo6S3lKjZrLN7m12TAMlFqHk38
         mGEiTJseDCBgATlf/35aROU3niJVJZr+RHJNi//prrBN/UmJsnTD8tXNfL3jimRH1Q
         adPIRJKoYCJLnPH7Q9ZIJAs70CYQeofeNGxn2WEM=
Date:   Sun, 29 Sep 2019 09:26:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jesse Barton <jessebarton95@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Staging: exfat: exfat_super.c: fixed multiple coding
 style issues with camelcase and parentheses
Message-ID: <20190929072657.GB1879787@kroah.com>
References: <20190929002233.21998-1-jessebarton95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929002233.21998-1-jessebarton95@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 07:22:33PM -0500, Jesse Barton wrote:
> Fixed coding style issues with camelcase on functions and various parentheses that were not needed

Please wrap your changelog text properly.

Only do one "type" of thing per patch, this should be two different
ones.

thanks,

greg k-h
