Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1706DC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBD9218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567961156;
	bh=TLSx0eDVVIR9BUeNWztuRR5XMMb45dshPOmxd+txMxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jmi90xyPR6w8unGQakY/xCAD+z9+8Q3SxRe0iiT2B+oUJP52CIJBN63sp1TI7FnfE
	 TmrWtXImAeeGLZbQHHAKckekZNHQbdA9Vcks6k9jFfQLk11ws2oNgWUWHBYM7JYUil
	 REDLfRxWOXqlh8usU3vZ+yTG2oxPAFTJEViD+9nA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfIHQp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 12:45:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfIHQpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:45:55 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C338221479;
        Sun,  8 Sep 2019 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567961155;
        bh=TLSx0eDVVIR9BUeNWztuRR5XMMb45dshPOmxd+txMxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUuEBmsIxz7gPIltGr0dKWkRGL8sQbJeLye44pKH2VyaYTozUwaU2hj89j4t85eqy
         orUE8bz3ZSvEGj4TK+uerA0IS6iwN5skalvteoeblB+iSPqf4R1h2CU0bfUVETvK0Q
         xWrFqypwXgivCnpSmny/qzefVHtJg6nejgvKW9G4=
Date:   Sun, 8 Sep 2019 17:45:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] staging: exfat: drop duplicate date_time_t struct
Message-ID: <20190908164552.GD8362@kroah.com>
References: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 04:10:13PM +0000, Valentin Vidic wrote:
> Use timestamp_t for everything and cleanup duplicate code.

You dropped function parameters in here, which you did not describe in
this changelog text :(

Please only try to do "one logical thing" per patch to make it easier to
review and revert if something goes wrong :)

thanks,

greg k-h
