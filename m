Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A50C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9E62147A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554282481;
	bh=CSTwK+jLbMfNOsZeNJiAvaZyJ9e8lv9nLjxxYJGCK4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ys/PlCtpFs2HoAIFZyEmlmKMJViEmp+T6W4QUKszVM6r6ZZSzDF+IXW6ZyfrNEFnQ
	 kJgCGjQ5cfwAJWsaDyL0p/zAxYEfQD+KlVPwYU3MU3bzylTGG7X23oCkR+1wnu4ibz
	 HeaUl2E3Xgzt712chlNHtZMboImFyogrRUbkae6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDCJH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:07:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfDCJH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:07:59 -0400
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB30820882;
        Wed,  3 Apr 2019 09:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554282478;
        bh=CSTwK+jLbMfNOsZeNJiAvaZyJ9e8lv9nLjxxYJGCK4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6gcQaXrHa30qu+WK4gL2Iec1l6Wb8ihRTDGY3GbNHqVBzslEUZxvROvly8G51lZV
         flC84JFheV9ejavPjXv/RoR0CX0kDD2V04+rF/X12gqgechKYhPDDNHR65iQM0wjCH
         xkUaS3oYNL+i4q1MXHEraevl+/qDzIyO1Dag5eds=
Date:   Wed, 3 Apr 2019 11:07:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        Aymen Qader <qader.aymen@gmail.com>,
        Tobias =?iso-8859-1?Q?B=FCttner?= <tobias.buettner@fau.de>,
        Dominic Braun <inf.braun@fau.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Alejandro Ismael Silva <silva.alejandro.ismael@gmail.com>,
        Phil Elwell <phil@raspberrypi.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 06/16] staging: vc04_services: remove remaining redundant
 license text
Message-ID: <20190403090749.GB23934@kroah.com>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
 <20190402103203.14959-7-gregkh@linuxfoundation.org>
 <a84e7740-cd9e-2d2e-fb6e-560776527e1e@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a84e7740-cd9e-2d2e-fb6e-560776527e1e@i2se.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 12:37:57PM +0200, Stefan Wahren wrote:
> Am 02.04.19 um 12:31 schrieb Greg Kroah-Hartman:
> > Now that the SPDX tag is in all vc04_services files, that identifies the
> > license in a specific and legally-defined manner.  So the extra GPL and
> > BSD text wording can be removed as it is no longer needed at all.
> >
> > This is done on a quest to remove the 700+ different ways that files in
> > the kernel describe the license text.
> >
> > No copyright headers or other non-license-description text was removed.
> >
> > Cc: Eric Anholt <eric@anholt.net>
> > Cc: Stefan Wahren <stefan.wahren@i2se.com>
> > Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
> > Cc: Aymen Qader <qader.aymen@gmail.com>
> > Cc: "Tobias Büttner" <tobias.buettner@fau.de>
> > Cc: Dominic Braun <inf.braun@fau.de>
> > Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Cc: Alejandro Ismael Silva <silva.alejandro.ismael@gmail.com>
> > Cc: Phil Elwell <phil@raspberrypi.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks for the acks.
