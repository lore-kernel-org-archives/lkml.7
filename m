Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B25DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7F320872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552923501;
	bh=UsUQhJ3PU95HvQG2VoZOuW5h6sHE+86iaoudalDZSXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y3qO0gHr9qVMIm8Non8JHbtpgA5BJd2uhDLd9L1Qjp+RRwA+iqpI+ZME6ZSMGXPzq
	 tPsgvTq1ADPyqbGnyxlryeTnStFLeLDidN8lNiU0dJbee/8CDLsObpqMMpypAYz9SI
	 /XDufNc2V5axwyGbIQdunelNBLi6G2D7JRyiOUgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfCRPiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfCRPiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:38:19 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CBE820854;
        Mon, 18 Mar 2019 15:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552923498;
        bh=UsUQhJ3PU95HvQG2VoZOuW5h6sHE+86iaoudalDZSXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8wwJIvPjXOKXsXTKoNS5B3VbtL9cbSut/atulWoB54eYDzeQFS5Jh9xPg+NL4tEM
         wFccM9C1H0AePKJ2MaPmcaJ72xeFptwSQP454iqCB175cXSCmulMb7wT2pF706ZIAq
         HFac/ovgur/LjwqPXYOBWhKBv9eNTcDWo2lOEGJQ=
Date:   Mon, 18 Mar 2019 16:38:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: erofs: Add whitespace after declaration
Message-ID: <20190318153816.GA15943@kroah.com>
References: <20190318153224.GA3596@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318153224.GA3596@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 09:02:24PM +0530, Bharath Vedartham wrote:
> Add whitespace after declaration. Fixed the checkpatch.pl warning.
> 
> ---

No signed-off-by?

> changes since v2
> 	- mutt gave me a lot of problems. Hence 3 patches for a really
> 	  small problem.
> 	- Fixed the extra missing line.
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>

It needs to be above the --- line, otherwise it will be stripped off
when applied.

v4 please?

thanks,

greg k-h
