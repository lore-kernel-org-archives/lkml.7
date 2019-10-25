Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941FACA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 00:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5CC21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 00:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571962673;
	bh=rqD7W4s+LZOUcm0Bvx9xbKfspitHAUdWO36YJUu908M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LspO3z804fnU2YYzIRG6vxT6YS4RrUn3p5iBYxLzRZBGa7gMlnDeAW66Fj6P4U27i
	 RA1C3ZyaFetQtyl+WFujxNM4t6mIknRfAdO6uUtI/exOVRnai7yA7sSsITF6VLJUuW
	 3lBZpaxkZfcJ5cNtvnHuMh1FIxIKz+QPtfWeXHw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbfJYARw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 20:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732374AbfJYARw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 20:17:52 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A16E21929;
        Fri, 25 Oct 2019 00:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571962671;
        bh=rqD7W4s+LZOUcm0Bvx9xbKfspitHAUdWO36YJUu908M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T4Pk3KomY52w6ti8D4zLshL8rlj/YqzLSsc7Wyzi+sJiH5DNvI0MGNQ6yAGlpz1Vi
         0KUF7+uVm2NsFgpSJapNZj6LLQIs9+3Vgb6OsqijNpPAEovnfKjUuGK8W/gEQBi0hR
         GrNxiblyVCdMuPB5KMZiPUb067qMD6Zwd+o+WgQc=
Date:   Thu, 24 Oct 2019 20:17:50 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Alessio Balsini <balsini@android.com>
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4.4 4.9 4.14] loop: Add LOOP_SET_DIRECT_IO to compat ioctl
Message-ID: <20191025001750.GE31224@sasha-vm>
References: <20190805115309.GJ2349@hirez.programming.kicks-ass.net>
 <20191023171736.161697-1-balsini@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191023171736.161697-1-balsini@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 06:17:36PM +0100, Alessio Balsini wrote:
>[ Upstream commit fdbe4eeeb1aac219b14f10c0ed31ae5d1123e9b8 ]
>
>Enabling Direct I/O with loop devices helps reducing memory usage by
>avoiding double caching.  32 bit applications running on 64 bits systems
>are currently not able to request direct I/O because is missing from the
>lo_compat_ioctl.
>
>This patch fixes the compatibility issue mentioned above by exporting
>LOOP_SET_DIRECT_IO as additional lo_compat_ioctl() entry.
>The input argument for this ioctl is a single long converted to a 1-bit
>boolean, so compatibility is preserved.
>
>Cc: Jens Axboe <axboe@kernel.dk>
>Signed-off-by: Alessio Balsini <balsini@android.com>
>Signed-off-by: Jens Axboe <axboe@kernel.dk>
>Signed-off-by: Sasha Levin <sashal@kernel.org>

Queued up, thanks!

-- 
Thanks,
Sasha
