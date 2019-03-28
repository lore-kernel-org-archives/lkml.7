Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F078C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298DB20700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfC1SFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:05:04 -0400
Received: from mail.hallyn.com ([178.63.66.53]:43072 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfC1SFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:05:04 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 2FFAAA74; Thu, 28 Mar 2019 13:05:03 -0500 (CDT)
Date:   Thu, 28 Mar 2019 13:05:03 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: Allowing mapping supplemental groups in user namespace?
Message-ID: <20190328180503.GA16249@mail.hallyn.com>
References: <CAKdAkRQj=bSSL2Cw3gAqi5f12yP3+KsvtrMvU4Lcfta_JYxMYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRQj=bSSL2Cw3gAqi5f12yP3+KsvtrMvU4Lcfta_JYxMYQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:27:38AM -0800, Dmitry Torokhov wrote:
> Hi Eric,
> 
> Currently, unless caller has CAP_SETGID in parent namespace, we can
> only map effective group id in the new user namespace. Would it be
> possible to relax this rule to also allow mapping of supplemental
> groups (1:1) of the caller?
> 
> Thanks.
> 
> -- 
> Dmitry

Hi,

Is there a use case where adding those to /etc/subgid is onerous?
(There probably is, just would like to see yours)

thanks,
-serge
