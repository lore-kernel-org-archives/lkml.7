Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3319C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FAB206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfCJSup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:50:45 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:49851 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfCJSuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:50:44 -0400
Received: from [192.168.1.110] ([95.118.75.201]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MmlbE-1gcHHN1ijO-00jq0d; Sun, 10 Mar 2019 19:50:23 +0100
Subject: Re: Debian build polishing
To:     Theodore Ts'o <tytso@mit.edu>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, apw@canonical.com, joe@perches.com,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org
References: <1552049064-32044-1-git-send-email-info@metux.net>
 <20190308175703.GA7178@lambda>
 <fe53cd84-5953-786a-3a4f-6eac652a1cdd@metux.net>
 <20190308215724.GA22319@mit.edu>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <341b78ca-9901-78f0-f404-59194f3da503@metux.net>
Date:   Sun, 10 Mar 2019 19:50:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190308215724.GA22319@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:EXEO90gebp7GRFtaKUhcA3Tn43Jia/LepSm/l7xrUkStWAqouv2
 jgluwvjgu+P4piPRPETEvS/6qdVD9CUGzaBc5jJ1WE02y+n4rTuGWXM6+VAaQWBHkRrAPHj
 0jPp/Iq0qs5brj7kNQNOI/BbUKUGerHjZJeFsS/xXU0GINO3mQUJwsaH+ImE4bTFh9/kWVO
 rFDaYL0Ppwc5shzeA7SPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VAfFX1BIva8=:IQsHEI6mgAjXWG9YpdPpDf
 zpUUozFUyL3pJOkbmMNYtxPt/F0lYkDiu1404pzHWqdpZSBq2pyByHmAOfmCOIYsouWZ3pR1F
 L5/3G7Lf9qxbalfNUzTPWl/vXCqfKqebCD/QkZZf5pboQJLNHhbu1jAcjo9Wm8B3q3HznXtZl
 HR8eorDalVpYVW3N+Gfx7A9/I6uxe6eWHkZFbdG+PpFGeJ3aJBCUXnT9of0r/+k9HDKZdprPK
 BFKAawyTAkUFCF1ZtQ6svmXJj8bLKajmtUMd0wV68+kxcRBCJcD3+DMcjI+8EfZVf2WrpWebO
 EKfZd6Y2SEOHQM//n8vorZRPtyvtqsxZNgmSfZNNHQ/mL44OWM2lMdRHAoqtzx43a1Y7gz2fx
 Fw9yH1f77WgICAO0Xdquc7JnK33/H2mtjavsewnDcIZBYeU1FTVhgo6X+lbJpUSei69U0YUuu
 DpcygZ+C3ZwBnSvypk0NCJatJblABKkrB3IipcPvHTBpKzRLFp/CvlrYgsBdTPaKDykV01b86
 ieFpLi8FfqXIvm1dLAbHrwR/rzGg8qceD72Ay5lxC82p+LRycNVU00lmOIy8IL8R+miiShoga
 TuzKu6l17pybs5MaR2pG3GEr1XUWDlFzz5fctoLQCuz0k/dgo1Rn6hTSkuEzVJ43SplGmlmdI
 9qT67TnNYbX5fGEdcQ5z+tcq5yOXTYEyE4PN0a4bQyYPZbLxydIznxhbmRc4hw41hukC7KqSN
 YTESv3j7ARHGaooO4oF1IemduJAREPilePqa71KSF8kxf+lDeyIU/GfVXzY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.19 22:57, Theodore Ts'o wrote:

> The full debian directory lands in the O= directory.  So presumably
> you could make it work for use case if there was a "make O=/build/dir
> debian-prepare" which copies the necessary debian/ files into the
> build directory and then someone could cd into /build/dir and run
> "dpkg-buildpackage"?

Didn't touch these rules at all, so it should still work as it used to.

I thought about changing the old deb rules to just call the new
debian/rules file, but haven't done so yet.

Maybe you could find some time to test whether my approach also
works for you ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
