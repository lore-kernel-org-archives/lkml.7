Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50835C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C40226194
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 20:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559249743;
	bh=yDOA7GRN66OKf/HVf3rvvqoJO+w8MLOsyGWqaIIZXrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ilVj25Hk1SjhTtrI4uyLLLY9FaP07XyeII4MGEXTAA0qlt1ma0LU5VoVrwEddc6GF
	 THiJv3IRHAxPXv9XwZOnhqZ2c30zxKyUZIajknEU8DTj3PoIBmp2rJ/cZvGrz6g/bV
	 8Wy8ozFDnAKFN/bswrZN4YMR3h4kxFAcSAnIM7WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfE3Uzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 16:55:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3Uzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 16:55:41 -0400
Received: from localhost (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC4B2618F;
        Thu, 30 May 2019 20:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559249741;
        bh=yDOA7GRN66OKf/HVf3rvvqoJO+w8MLOsyGWqaIIZXrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pVQxZ9OfBotKIjY+BdiEg0GPaJ/L49vuVoM5P9BCsB9uVQpMfo9JEL75Cya0l6T+9
         dqqMYdYrgn5zavUlWbn4yDGHhnWDdrIwRE5Gt2QoopT087/q9X3AkyUrMYSnaJv/BM
         a0JGeh6IAB+LZHYo1ALheQmVF1031YGUrgOEhlOI=
Date:   Thu, 30 May 2019 13:55:40 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     hans.verkuil@cisco.com, mchehab@kernel.org, code@wizofe.uk,
        ezequiel@collabora.com, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: media: davinci_vpfe: Remove variable vpfe_dev
Message-ID: <20190530205540.GA5308@kroah.com>
References: <20190530204718.29892-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530204718.29892-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 02:17:18AM +0530, Nishka Dasgupta wrote:
> Remove variable vpfe_dev and replace it with its value (since the
> function otherwise uses values directly instead of local variables).

This says _what_ you do.  But we can see that in the patch itself.

You need to say _why_ you are doing this.

There's no need for this change at all.  Again, as I have said before,
we write code for developers to read first, the compiler second.  By
making these types of changes you are making it harder to
read/understand by a developer, and providing absolutely no benifit to
the compiler at all.

So it's actually making the code worse!

not good at all.

Please reconsider this type of change, as I keep asking you to.

greg k-h
