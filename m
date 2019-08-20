Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867B5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A685214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfHTOJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:09:57 -0400
Received: from smtprelay0055.hostedemail.com ([216.40.44.55]:49221 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729155AbfHTOJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:09:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 2429C100E86C6;
        Tue, 20 Aug 2019 14:09:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: juice52_1c3ac93d74b63
X-Filterd-Recvd-Size: 3840
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 20 Aug 2019 14:09:53 +0000 (UTC)
Message-ID: <b7190f9c3fedb5d4055cfd2802eb025140ce56d4.camel@perches.com>
Subject: Re: Status of Subsystems
From:   Joe Perches <joe@perches.com>
To:     Sebastian Duda <sebastian.duda@fau.de>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 20 Aug 2019 07:09:52 -0700
In-Reply-To: <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
References: <2529f953-305f-414b-5969-d03bf20892c4@fau.de>
         <20190820131422.2navbg22etf7krxn@pali>
         <3cf18665-7669-a33c-a718-e0917fa6d1b9@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-20 at 15:56 +0200, Sebastian Duda wrote:
> On 20.08.19 15:14, Pali Rohár wrote:
> > On Tuesday 20 August 2019 15:05:51 Sebastian Duda wrote:
> > > Hello Pali,
> > > 
> > > in my master thesis, I'm using the association of subsystems to
> > > maintainers/reviewers and its status given in the MAINTAINERS file.
> > > During the research I noticed that there are several subsystems without a
> > > status in the maintainers file. One of them is the subsystem `ALPS PS/2
> > > TOUCHPAD DRIVER` where you're mentioned as reviewer.
> > > 
> > > Is it intended not to mention a status for your subsystems?
> > > What is the current status of these systems?
> > > 
> > > Kind regards
> > > Sebastian Duda
> > 
> > Hi Sebastian! ALPS PS/2 is a driver for ALPS touchpad. They can be
> > found on more laptops. And ALPS PS/2 itself is not separate subsystem.
> > It is just driver which is part of kernel input subsystem with mailing
> > list linux-input@vger.kernel.org.
> > 
> Hi Pali,
> 
> so the status of the files is inherited from the subsystem `INPUT 
> MULTITOUCH (MT) PROTOCOL`?

Not really, no.

It's inherited from

MAINTAINERS-INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN) DRIVERS
MAINTAINERS-M:  Dmitry Torokhov <dmitry.torokhov@gmail.com>
MAINTAINERS-L:  linux-input@vger.kernel.org
MAINTAINERS-Q:  http://patchwork.kernel.org/project/linux-input/list/
MAINTAINERS-T:  git git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
MAINTAINERS-S:  Maintained
MAINTAINERS:F:  drivers/input/
MAINTAINERS-F:  include/linux/input.h
MAINTAINERS-F:  include/uapi/linux/input.h
MAINTAINERS-F:  include/uapi/linux/input-event-codes.h
MAINTAINERS-F:  include/linux/input/
MAINTAINERS-F:  Documentation/devicetree/bindings/input/
MAINTAINERS-F:  Documentation/devicetree/bindings/serio/
MAINTAINERS-F:  Documentation/input/

You could see this via

$ ./scripts/get_maintainer.pl -f --sections drivers/input/mouse/alps.c
ALPS PS/2 TOUCHPAD DRIVER
R:	Pali Rohár <pali.rohar@gmail.com>
F:	drivers/input/mouse/alps.*

INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN) DRIVERS
M:	Dmitry Torokhov <dmitry.torokhov@gmail.com>
L:	linux-input@vger.kernel.org
Q:	http://patchwork.kernel.org/project/linux-input/list/
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
S:	Maintained
F:	drivers/input/
F:	include/linux/input.h
F:	include/uapi/linux/input.h
F:	include/uapi/linux/input-event-codes.h
F:	include/linux/input/
F:	Documentation/devicetree/bindings/input/
F:	Documentation/devicetree/bindings/serio/
F:	Documentation/input/

THE REST
M:	Linus Torvalds <torvalds@linux-foundation.org>
L:	linux-kernel@vger.kernel.org
Q:	http://patchwork.kernel.org/project/LKML/list/
T:	git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
S:	Buried alive in reporters
F:	*
F:	*/


