Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF686C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCEE2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554233856;
	bh=lqdl/wqQSBRmpSFyVR/SMGOasWuRJLRa0QFv9x5+XOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pxJTO1sRg43C1a7yFdI9WAJljn4y0Hl0xvViqDcZ3b6uuuf+lhQy00Yko4a31nTbQ
	 9AlnffotClWkkxmIEg4q0gayrg43PDtOHX7VgxKeabraGHWQcFhnZBJsgyXeVZVNql
	 p2HkkG7YIgKkIWCNuhVheWPqELeLICMh7JOrsKHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfDBThf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfDBThf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:37:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DC32070D;
        Tue,  2 Apr 2019 19:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554233854;
        bh=lqdl/wqQSBRmpSFyVR/SMGOasWuRJLRa0QFv9x5+XOE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uu1VDcrUuf9hQxvY6f0UzqFD4+JcdNu4TKeVxWcq74ovPRFnvMRyTDICEUWeOfZ1l
         VTf6eXs45wCr1ZSdU2ZOTenUImadEJRccS29GJdyvG7EpIX3J9ZI5YXdwFBjrI5LIX
         fr4Td4VZrwMnMai8KYavRE1dtbn7SQP0bqnOdPDE=
Date:   Tue, 2 Apr 2019 21:37:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-kernel@microsoft.com, bryankel@microsoft.com,
        thiruan@microsoft.com, suredd@microsoft.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/2] ftpm: dt-binding: add dts documentation for fTPM
 driver
Message-ID: <20190402193732.GA26193@kroah.com>
References: <20190402193316.15144-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402193316.15144-1-sashal@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 03:33:15PM -0400, Sasha Levin wrote:
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

I know I don't take patches without any changelog text :)

