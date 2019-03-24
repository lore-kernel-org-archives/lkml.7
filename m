Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC0AC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768F721741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553417917;
	bh=9IGZHR7WdexRye9Zr/rhKoFLl35GPU4IU7s1+MUXRT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XZXqF9BzTp2k6JejNdohr12iFdzqRiKUWkiA17R8EMCgM9OU6ywX9RP8pYqNllwaN
	 Q+gvg0yEwJwi0PNWpYZsT/t3n0FXBYKEupVHXro5bRgSoiRuZaogEYcsyoJhOH3KaN
	 Hnd3vcEbQXxoWeC1UhkqCVZdmSOFzJZ0seObklwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfCXI6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 04:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfCXI6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 04:58:35 -0400
Received: from localhost (unknown [89.248.140.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4BC32171F;
        Sun, 24 Mar 2019 08:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553417915;
        bh=9IGZHR7WdexRye9Zr/rhKoFLl35GPU4IU7s1+MUXRT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBUABBWXwXGWVYiGeTmv5UHD/6nJHSSVjwE3z0moc2wZLUK1E97JwKE4Ci/7WG2FS
         pXYk+ClnPRSM0aww8AxcYh2BDuwZI/4gzIk/HAiy6yp6GKly6qMHkH40Fk55BsvtY3
         iuE+Pee2w6P6TjTAw3FIiGrtKiT08iBbty+BM8dk=
Date:   Sun, 24 Mar 2019 09:58:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     philipp.panzer@fau.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: ralink-gdma: Use u32 over uint32_t
Message-ID: <20190324085833.GA21912@kroah.com>
References: <20190323154648.GA10634@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323154648.GA10634@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 09:16:48PM +0530, Bharath Vedartham wrote:
> Fixes the checkpatch.pl warning: "Prefer u32 over uint32_t"
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
> Changes since v3
> 	- Fixed allignment issues.
> 	- Submitted a seperate patch to change unsigned
> 	to unsigned int.
> 	- One of the allignments crosses 80 characters in a line
> 	but I feel that we may loose readability if we try to reduce
> 	the characters in the line.
> ---
>  drivers/staging/ralink-gdma/ralink-gdma.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

This patch does not apply to my staging-testing branch at all :(
