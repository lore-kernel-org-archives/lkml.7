Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BE1C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3E320659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 09:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="bXcOKmYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfJNJWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 05:22:24 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:37781 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbfJNJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 05:22:23 -0400
Date:   Mon, 14 Oct 2019 09:22:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1571044941;
        bh=GNIUeV2PuZLavbtg2ZGccQlI/K/j81rR62oMYmqSBOQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=bXcOKmYxGh3vGMlF8bG2pTRj3pvMMbr8GTC8I/lZexfnv1xNvglc8H/t9AGGFWI0t
         La/yH/j0jFzPcFbzh7hunuVD5Xw9IRK8ARtFb8GmQxcRX+ebdvolEiJFP1bG0Jk58k
         rCnIIH5KoWWLKH8+EYSmml1jOjv29J+4GktcMQ/4=
To:     Daniel Vetter <daniel@ffwll.ch>
From:   Simon Ser <contact@emersion.fr>
Cc:     syzbot <syzbot+e7ad70d406e74d8fc9d0@syzkaller.appspotmail.com>,
        "hamohammed.sa@gmail.com" <hamohammed.sa@gmail.com>,
        "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "oleg.vasilev@intel.com" <oleg.vasilev@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "simon.ser@intel.com" <simon.ser@intel.com>,
        "omrigann@gmail.com" <omrigann@gmail.com>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: WARNING in vkms_gem_free_object
Message-ID: <ActXXBRCAJY1WXkb1rRkIIdrHBvij0nuYv61GfTkwduOvS-mmb2jOAFmwxq0UPOZeZFXxWIhkOZBgYPSUFxKdGgxmYcPVBUk8IF6PodWFg8=@emersion.fr>
In-Reply-To: <20191014091736.GJ11828@phenom.ffwll.local>
References: <0000000000006bed900594d5e99a@google.com>
 <20191014091736.GJ11828@phenom.ffwll.local>
Feedback-ID: FsVprHBOgyvh0T8bxcZ0CmvJCosWkwVUg658e_lOUQMnA9qynD8O1lGeniuBDfPSkDAUuhiKfOIXUZBfarMyvA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 14, 2019 12:17 PM, Daniel Vetter <daniel@ffwll.ch> wrote=
:

> Oleg, will you be looking at this? With the reproducer and full drm
> debugging enabled it shouldn't be too hard to figure out what's going on
> heere ...

Oleg is no longer working at Intel. I don't think he monitors dri-devel
anymore.

I'd like to work on VKMS myself, but it's very unlikely I have time to
do so anytime soon.

(Neither Oleg nor I have access to our @intel.com address anymore.)
