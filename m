Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729D2C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3905821841
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 05:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558677254;
	bh=ONC/f7PSUMLvU8uHL8UeQLAqkiAgt5almKSfUJCHY28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d+OgNqDPwn+TAjrOU7w/Dpy6w9innvNqABjsZlKpWhWEXYjz8I00beCrlHAzaJUpc
	 EWaAwgR2CT5NqwLgGp3CkPTW3dcRZMX6DCWDqycC6PI4jfi5fhjWjQiEseLNZVKf2n
	 H33SaBJWbZmwRnR0LApbxa/ERqswCbHZ5ggRdUQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbfEXFyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 01:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387703AbfEXFyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 01:54:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FEDD2081C;
        Fri, 24 May 2019 05:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558677252;
        bh=ONC/f7PSUMLvU8uHL8UeQLAqkiAgt5almKSfUJCHY28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gEvA2trISUTXjS3l1UQ3XuxztazbgoePeqNUjzCxHw0GQGf+UpOYnz0HxyiEfwB3e
         eSVZAPy7L3T04wCyQhkPjDGniRw9kFqNSSL8eaYNxcm8vQqH8kudAyvABklf6hEwsQ
         a6bo49YVXVYXlM8KFMJVB5/dB74qBXENEVl0dWbI=
Date:   Fri, 24 May 2019 07:54:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     stable <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please cherrypick 592acbf1682128 to 3.18.y and 4.4.y
Message-ID: <20190524055409.GE31664@kroah.com>
References: <6f545e7c-fda8-4bec-33fc-283ebf492372@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f545e7c-fda8-4bec-33fc-283ebf492372@android.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 01:49:27PM -0700, Mark Salyzyn wrote:
> Cherry pick security-related fix 592acbf16821288ecdc4192c47e3774a4c48bb64
> ("ext4: zero out the unused memory region in the extent tree block") to
> 3.18.y and 4.4.y
> 
> The cherry-pick is clean and requires no back-porting. Is already present in
> 4.9.y+
> 
> Signed-off-by: Mark Salyzyn<salyzyn@android.com>
> 
> To: stable <stable@vger.kernel.org> # 3.18.y 4.4.y
> 
> Cc: LKML <linux-kernel@vger.kernel.org>

It's already in the 4.4 queue.  And in my internal 3.18 queue as well.
Need to put that somewhere public soon...

thanks,

greg k-h
