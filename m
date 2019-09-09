Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26CCC49ED6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 19:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8088E21A4C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 19:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405712AbfIITeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 15:34:46 -0400
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:59174 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726814AbfIITeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 15:34:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id AD784AF9B;
        Mon,  9 Sep 2019 19:34:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ball72_6381a34270650
X-Filterd-Recvd-Size: 1705
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Sep 2019 19:34:43 +0000 (UTC)
Message-ID: <7053662366e29927123b9881c05aeae299c850f8.camel@perches.com>
Subject: Re: [PATCH 2/9] thunderbolt: show key using %*s not %*pE
From:   Joe Perches <joe@perches.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Date:   Mon, 09 Sep 2019 12:34:42 -0700
In-Reply-To: <1567712673-1629-2-git-send-email-bfields@redhat.com>
References: <20190905193604.GC31247@fieldses.org>
         <1567712673-1629-1-git-send-email-bfields@redhat.com>
         <1567712673-1629-2-git-send-email-bfields@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-05 at 15:44 -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> %*pEp (without "h" or "o") is a no-op.  This string could contain
> arbitrary (non-NULL) characters, so we do want escaping.  Use %*pE like
> every other caller.
[]
> diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
[]
> @@ -636,7 +636,7 @@ static ssize_t key_show(struct device *dev, struct device_attribute *attr,
>  	 * It should be null terminated but anything else is pretty much
>  	 * allowed.
>  	 */
> -	return sprintf(buf, "%*pEp\n", (int)strlen(svc->key), svc->key);
> +	return sprintf(buf, "%*pE\n", (int)strlen(svc->key), svc->key);

The code does not match the patch subject / commit title.


