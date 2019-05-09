Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B751C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0E921019
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557422805;
	bh=+HWOJWOCda4WPFNFu0qxbHqKganmYVdnc+DRZUNNIBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E+COpANWvi/3Y4u4tQZV2VwlbzD8JKvb54ZWsq41gY5MK3HqVQmjysTc/3AxwkHvI
	 5n6SkJ1M9L7KqkIMQ60xvGraOkHDFb4L2JN4xBvGQ2egakGnmbGE+FgMG7YJ1T/CPd
	 f6TWl2vvPn3OKlq2++Cy7O658G+r4n2HRtRLfMYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfEIR0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:26:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfEIR0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:26:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 852F220656;
        Thu,  9 May 2019 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557422802;
        bh=+HWOJWOCda4WPFNFu0qxbHqKganmYVdnc+DRZUNNIBE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kSsNXW1jWywR+W/W2+fzX6t10eUE5S0vGeCuHaOq4dDGuwlffAdbS5pnzYT9I/QA3
         1/cMOyz8+2o3sZHvEfFZY6m6uW+jUsIqQpf1qBMhBgjFuCT4wojd0Ql4JvW5b3wZrI
         lQfvMGmVENsnYIp4mPhf7w8bdJwMwl8oTUozn0aA=
Date:   Thu, 9 May 2019 19:26:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] lkdtm fixes for next
Message-ID: <20190509172639.GA32539@kroah.com>
References: <201905091017.DA22A3E0C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905091017.DA22A3E0C@keescook>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 10:19:39AM -0700, Kees Cook wrote:
> Hi Greg,
> 
> Please pull these lkdtm fixes for next. If possible, it'd be nice to get
> these into v5.2 (they're small fixes), but I'm fine if they have to wait.
> I meant to send these earlier, but got distracted by other things.

Will look at these once 5.2-rc1 is out, thanks.

greg k-h
