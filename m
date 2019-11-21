Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEFAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312B52075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574298896;
	bh=0YhXESY5Img+bDLyS0DkVrNjXOfbzeStiFQlNIzzGZ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B29gHQA2li1TSIk8L/W7xYP/tS2JZjJo4OA5CA8TxJZ48rLeMoM1WsIKxXn4YRBVK
	 GiYi7QhdsuiQ9Fy05etCfeoovsP0ZhwIPg1RG8sOs72HPPqccwV1bMUL1wuNG0VHTv
	 NkfT+MwItGIG0lS0aqM+r/EKUOWnDCqtX7JYLZok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfKUBOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:14:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfKUBOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:14:54 -0500
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F36CE20898
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 01:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574298894;
        bh=0YhXESY5Img+bDLyS0DkVrNjXOfbzeStiFQlNIzzGZ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k99Px07GTebnY/clhcdtK17Zbz+hNnISxxCkaD6jDrti+6IBgP55V0GRWpqg0YAB7
         F171w1KIxZ0jicpzxrheN42/RizH/RNZmdhTIjHg30WL2fe/SMmZ3wWVXSoAHyv6xB
         kbguBgjgLrKbLIvHCviuRLp9yCf3Y0z1+hraHonI=
Received: by mail-lf1-f50.google.com with SMTP id f16so1154687lfm.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 17:14:53 -0800 (PST)
X-Gm-Message-State: APjAAAVUiKsH2tEaSn+cF6kfUQT5bYt/pzZI7viHPt85QGimsCUR3d7E
        B7PJaqV5MlNoaCPJA/r9+QTOF8CeP+36YV6dM98=
X-Google-Smtp-Source: APXvYqwxOI7j8UNtoDwJ2RlML55Fi33YOEKFeEzv23JmFFyiMCSjUpIN4ZQ4V6gEDr4+LM9PWjmNk7O/L7gtOhnP5Kk=
X-Received: by 2002:ac2:5228:: with SMTP id i8mr5106648lfl.69.1574298892107;
 Wed, 20 Nov 2019 17:14:52 -0800 (PST)
MIME-Version: 1.0
References: <20191120134340.16770-1-krzk@kernel.org> <20191120140146.GA21065@nautica>
In-Reply-To: <20191120140146.GA21065@nautica>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 21 Nov 2019 09:14:40 +0800
X-Gmail-Original-Message-ID: <CAJKOXPeGm=2_p8SWwgUbf-hTDyi91PhtvPzTL_ZxkM9ADg1dNA@mail.gmail.com>
Message-ID: <CAJKOXPeGm=2_p8SWwgUbf-hTDyi91PhtvPzTL_ZxkM9ADg1dNA@mail.gmail.com>
Subject: Re: [PATCH] 9p: Fix Kconfig indentation
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 at 22:08, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
> Krzysztof Kozlowski wrote on Wed, Nov 20, 2019:
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> >       $ sed -e 's/^        /\t/' -i */Kconfig
>
> I take it janitors weren't interested in these?
>
> Since it's just 9p I can take it, but if this is the only patch I get it
> might take a couple of months to get in.
> Will do depending on your answer.

Neither trivial nor kernel-janitors picked up previous version so
let's feel free to take, even if it sits in your tree for some time.

Best regards,
Krzysztof
