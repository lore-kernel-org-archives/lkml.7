Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2F0CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109AB20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 16:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572886018;
	bh=sYcDK73tFZoyMTCPD69+QGP17PeoJr16f74gTN3ha84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tbu0xuqvWHLlTYlax+3NSW9y68u7gMz3riKZBFkOn//we5vUHlQKQWMQasaPpU8Kw
	 0f0K98/5/u1N6pjYK5Oj58nP3LZ/dbT7LYGdSxqmSa4/NVmgM1lfrFPRY/R83iWDYS
	 j454zicHS0Kc9OLrAaiCRFngepBQZ+kcNRBVC7C0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfKDQq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 11:46:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbfKDQq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 11:46:56 -0500
Received: from localhost (host6-102.lan-isdn.imaginet.fr [195.68.6.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A96272084D;
        Mon,  4 Nov 2019 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572886016;
        bh=sYcDK73tFZoyMTCPD69+QGP17PeoJr16f74gTN3ha84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dTD9s701LlwjQ8YBFR3DBhM4ey5e2rsTqm6aoJbfy/OYQx1JtWJ1SjnK0yLjgK13C
         VXHASmfPa5h01/kOkHPwg3CfoqDTFWTzeSWxo9uC9ZDNPUbiEPlrDz3t4R/JtBa+70
         p3Wevx6vzSuIat6qt3sRrEvlwllcQt7PjE46P99A=
Date:   Mon, 4 Nov 2019 17:46:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, abbotti@mev.co.uk
Subject: Re: [PATCH v2] staging: comedi: rewrite macro function with GNU
 extension typeof
Message-ID: <20191104164653.GA2281588@kroah.com>
References: <20191104163331.68173-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104163331.68173-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:33:31PM +0000, Jules Irenge wrote:
> Rewrite macro function with the GNU extension typeof
> to remove a possible side-effects of MACRO argument reuse "x".
>  - Problem could rise if arguments have different types
> and different use though.

You can not just get away with a potential problem by documenting it :)

You might have just broken this.  Why are you trying to "fix" something
that is not broken?

What is wrong with the code as-is?

thanks,

greg k-h
