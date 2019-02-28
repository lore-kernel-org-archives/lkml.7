Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF23C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478E9218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551346305;
	bh=VRfS5hHqsQnfvZ6uDmGRT/QaXI20tW/1x+XOna8gZhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P0bhl4AYZ/gEYtAHOpIutz4eWOyUqFjXyGcYclmW5ZO0Hns27rUH2uIxHVvI4Pg86
	 2jSxYhK0UN+smzB2FtUAM+Hf1mlFeyGz/eTs1xfmqLsd9F2E1qwJKsLL3a0xIq7Atz
	 xR4NKQM7d8Xj143DgRnh/vW1+FeVG6n0PLJmhB2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfB1Jbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:31:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfB1Jbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:31:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFDA92171F;
        Thu, 28 Feb 2019 09:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551346302;
        bh=VRfS5hHqsQnfvZ6uDmGRT/QaXI20tW/1x+XOna8gZhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iBgwshlYgjto1R0rTPuHoVIBWWvaOLxc1nqzKxOWgYRi345oH7cgWHHG5/0/EdLuj
         AW3xtLBNNjhUg9ejAM3PKIWIMQDjyXBEMW88iQJ14j4ugFxIVE3sNASIjh+ntpoHnq
         UZFqozwFUaqDn4seLjK6ta0UgeFu1RnOUS6DiRUo=
Date:   Thu, 28 Feb 2019 10:31:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/15] habanalabs: print pointer using %p
Message-ID: <20190228093140.GA32514@kroah.com>
References: <20190228084624.25288-1-oded.gabbay@gmail.com>
 <20190228084624.25288-12-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228084624.25288-12-oded.gabbay@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:46:20AM +0200, Oded Gabbay wrote:
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

I can't take patches without any changelog text :(

