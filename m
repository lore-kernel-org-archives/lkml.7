Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336AAC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3F32081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556809491;
	bh=G12hwoJxaNKVEQ4UsXviaadA3S/HOz6FBGqEV5qyrTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A9QZm/Kyhc17dGYdiALINeuOZLV1Tqe5U1osQ7Q7nbKJINgKIp3oOZmwISFhLGsW5
	 cwQBHKI5VT4Z/uDStoMPbb+Py1BBiFDgzrGEtagaGjOdFVLm+CpIDd3lpWadzHxmgy
	 g/rFTZEqQXn+SZSBxTGSbzXxSxEK9W0Wa6zS9wtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfEBPEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBPEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:04:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C0C32075E;
        Thu,  2 May 2019 15:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556809487;
        bh=G12hwoJxaNKVEQ4UsXviaadA3S/HOz6FBGqEV5qyrTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wjv2WfcdF3oV4zRpKTX/st6qIZLgdY6atMy5CjFKmhIV1XQPeqE1LO+hfcJKCU42l
         X6+tSXGb1AW0hxsBLuqcGXRfqsoAjK9QGMyMdo7ukOSxC5rCygguvTAl/a9HznqFFc
         /pF5M6bHkv/nMLMNiacXV8gmQwTIgOPeiq11Vj14=
Date:   Thu, 2 May 2019 17:04:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] USB: serial: io_edgeport: mark expected switch
 fall-throughs
Message-ID: <20190502150443.GA12003@kroah.com>
References: <20190501213329.GA26972@embeddedor>
 <20190502102608.GS26546@localhost>
 <df1feb28-58d0-7ac8-644d-0b48e5078edf@embeddedor.com>
 <20190502135636.GT26546@localhost>
 <f3fd7ece-98ff-4b67-6115-5f599e183508@embeddedor.com>
 <20190502144041.GA17960@kroah.com>
 <20190502144729.GB17960@kroah.com>
 <122f54b9-16e9-317b-42af-88bef6d6e3b0@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <122f54b9-16e9-317b-42af-88bef6d6e3b0@embeddedor.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 09:57:22AM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 5/2/19 9:47 AM, Greg Kroah-Hartman wrote:
> > On Thu, May 02, 2019 at 04:40:41PM +0200, Greg Kroah-Hartman wrote:
> >> On Thu, May 02, 2019 at 09:28:37AM -0500, Gustavo A. R. Silva wrote:
> >>>
> >>>
> >>> On 5/2/19 8:56 AM, Johan Hovold wrote:
> >>>> On Thu, May 02, 2019 at 08:22:30AM -0500, Gustavo A. R. Silva wrote:
> >>>>>
> >>>>>
> >>>>> On 5/2/19 5:26 AM, Johan Hovold wrote:
> >>>>>> On Wed, May 01, 2019 at 04:33:29PM -0500, Gustavo A. R. Silva wrote:
> >>>>>>> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >>>>>>> cases where we are expecting to fall through.
> >>>>>>>
> >>>>>>> This patch fixes the following warnings:
> >>>>>>>
> >>>>>>> drivers/usb/serial/io_edgeport.c: In function ‘process_rcvd_data’:
> >>>>>>> drivers/usb/serial/io_edgeport.c:1750:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>>>>>>     if (bufferLength == 0) {
> >>>>>>>        ^
> >>>>>>> drivers/usb/serial/io_edgeport.c:1755:3: note: here
> >>>>>>>    case EXPECT_HDR2:
> >>>>>>>    ^~~~
> >>>>>>> drivers/usb/serial/io_edgeport.c:1810:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>>>>>>      if (bufferLength == 0) {
> >>>>>>>         ^
> >>>>>>> drivers/usb/serial/io_edgeport.c:1816:3: note: here
> >>>>>>>    case EXPECT_DATA: /* Expect data */
> >>>>>>>    ^~~~
> >>>>>>>
> >>>>>>> Warning level 3 was used: -Wimplicit-fallthrough=3
> >>>>>>>
> >>>>>>> Notice that, in this particular case, the code comments are modified
> >>>>>>> in accordance with what GCC is expecting to find.
> >>>>>>>
> >>>>>>> This patch is part of the ongoing efforts to enable
> >>>>>>> -Wimplicit-fallthrough.
> >>>>>>>
> >>>>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>>>>>> ---
> >>>>>>> Changes in v2:
> >>>>>>>  - Warning level 3 is now used: -Wimplicit-fallthrough=3
> >>>>>>>    instead of warning level 2.
> >>>>>>>  - All warnings in the switch statement are addressed now.
> >>>>>>>
> >>>>>>> Notice that these are the last remaining fall-through warnings
> >>>>>>> in the USB subsystem. :)
> >>>>>>
> >>>>>>>  drivers/usb/serial/io_edgeport.c | 3 ++-
> >>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> >>>>>>> index 4ca31c0e4174..7ad10328f4e2 100644
> >>>>>>> --- a/drivers/usb/serial/io_edgeport.c
> >>>>>>> +++ b/drivers/usb/serial/io_edgeport.c
> >>>>>>> @@ -1751,7 +1751,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> >>>>>>>  				edge_serial->rxState = EXPECT_HDR2;
> >>>>>>>  				break;
> >>>>>>>  			}
> >>>>>>> -			/* otherwise, drop on through */
> >>>>>>> +			/* Fall through - otherwise, drop on through */
> >>>>>>>  		case EXPECT_HDR2:
> >>>>>>>  			edge_serial->rxHeader2 = *buffer;
> >>>>>>>  			++buffer;
> >>>>>>> @@ -1813,6 +1813,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> >>>>>>>  				}
> >>>>>>>  				/* Else, drop through */
> >>>>>>>  			}
> >>>>>>> +			/* Fall through */
> >>>>>>>  		case EXPECT_DATA: /* Expect data */
> >>>>>>
> >>>>>> Looks like you forgot to take the original review feedback you got into
> >>>>>> account:
> >>>>>>
> >>>>>> 	https://lkml.kernel.org/r/87k1zf4k24.fsf@miraculix.mork.no
> >>>>>>
> >>>>>
> >>>>> Oh, the thing is that the fall-through comments have to be placed at
> >>>>> the very bottom of the case. Also, based on that feedback, this time
> >>>>> I left the "Else, drop through" comment in place, so people can be
> >>>>> informed that such fall-through is conditional.
> >>>>>
> >>>>> What do you think about this:
> >>>>>
> >>>>> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> >>>>> index 4ca31c0e4174..52f27fc82563 100644
> >>>>> --- a/drivers/usb/serial/io_edgeport.c
> >>>>> +++ b/drivers/usb/serial/io_edgeport.c
> >>>>> @@ -1751,7 +1751,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> >>>>>                                 edge_serial->rxState = EXPECT_HDR2;
> >>>>>                                 break;
> >>>>>                         }
> >>>>> -                       /* otherwise, drop on through */
> >>>>> +                       /* Fall through - otherwise, drop on through */
> >>>>>                 case EXPECT_HDR2:
> >>>>>                         edge_serial->rxHeader2 = *buffer;
> >>>>>                         ++buffer;
> >>>>> @@ -1813,6 +1813,11 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> >>>>>                                 }
> >>>>>                                 /* Else, drop through */
> >>>>>                         }
> >>>>> +                       /* Beware that, currently, there are at least three
> >>>>> +                        * break statements in this case block, so the
> >>>>> +                        * fall-through marked below is NOT unconditional.
> >>>>> +                        */
> >>>>> +                       /* Fall through */
> >>>>>                 case EXPECT_DATA: /* Expect data */
> >>>>>                         if (bufferLength < edge_serial->rxBytesRemaining) {
> >>>>>                                 rxLen = bufferLength;
> >>>>
> >>>> It's better than v2, but I thought you said you were gonna look into
> >>>> restructuring the code to maintain (or even improve) readability?
> >>>>
> >>>
> >>> At first, I thought about that, but now I don't think that's realistic.
> >>> I'd turn the if-else into a switch, and based on the history of feedback
> >>> on this patch, we will end up having the same complains about the break
> >>> statements in that new switch and the possibility of a fall-through to
> >>> case EXPECT_DATA. At the end I would still have to add a comment explaining
> >>> that the last fall-through mark in unconditional.
> >>
> >> I love it how no one is blaming the original author of this code (i.e.
> >> me...)
> >>
> >> Let me see if I can fix it up to be more "sane", this is my fault.
> > 
> > How about the following patch?  Johan, this look nicer to you?  It makes
> > more sense to me.
> > 
> 
> Thanks, Greg. Just notice that, unfortunately, the original complains are
> still applicable to your patch. :/

Really?  I got rid of the crazy nesting, it should be more obvious what
is happening here now:

> > diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> > index 4ca31c0e4174..732081b3718f 100644
> > --- a/drivers/usb/serial/io_edgeport.c
> > +++ b/drivers/usb/serial/io_edgeport.c
> > @@ -1751,7 +1751,8 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> >  				edge_serial->rxState = EXPECT_HDR2;
> >  				break;
> >  			}
> > -			/* otherwise, drop on through */
> > +			/* Fall through */
> > +

"otherwise" makes no sense here, it's obvious that if the buffer isn't
big enough we need to pass through and keep parsing.

> >  		case EXPECT_HDR2:
> >  			edge_serial->rxHeader2 = *buffer;
> >  			++buffer;
> > @@ -1790,29 +1791,21 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> >  						edge_serial->rxHeader2, 0);
> >  				edge_serial->rxState = EXPECT_HDR1;
> >  				break;

The switch case is broken out here, so let's unindent the next block:


> > -			} else {
> > -				edge_serial->rxPort =
> > -				    IOSP_GET_HDR_PORT(edge_serial->rxHeader1);
> > -				edge_serial->rxBytesRemaining =
> > -				    IOSP_GET_HDR_DATA_LEN(
> > -						edge_serial->rxHeader1,
> > -						edge_serial->rxHeader2);
> > -				dev_dbg(dev, "%s - Data for Port %u Len %u\n",
> > -					__func__,
> > -					edge_serial->rxPort,
> > -					edge_serial->rxBytesRemaining);
> > -
> > -				/* ASSERT(DevExt->RxPort < DevExt->NumPorts);
> > -				 * ASSERT(DevExt->RxBytesRemaining <
> > -				 *		IOSP_MAX_DATA_LENGTH);
> > -				 */
> > -
> > -				if (bufferLength == 0) {
> > -					edge_serial->rxState = EXPECT_DATA;
> > -					break;
> > -				}
> > -				/* Else, drop through */
> >  			}
> > +
> > +			edge_serial->rxPort = IOSP_GET_HDR_PORT(edge_serial->rxHeader1);
> > +			edge_serial->rxBytesRemaining = IOSP_GET_HDR_DATA_LEN(edge_serial->rxHeader1,
> > +									      edge_serial->rxHeader2);
> > +			dev_dbg(dev, "%s - Data for Port %u Len %u\n", __func__,
> > +				edge_serial->rxPort,
> > +				edge_serial->rxBytesRemaining);
> > +
> > +			if (bufferLength == 0) {
> > +				edge_serial->rxState = EXPECT_DATA;
> > +				break;
> > +			}
> > +			/* Fall through */
> > +

This should make it more obvious.

at least it is to me now, it's much easier to read, and gcc should also
be happy about it.

Parsers are a pain, you have to handle stuff like this in messy ways.

Personally, I'm horrible at parsers, but this really looks to be the
simplest way to write this code at the moment.

Johan, any thoughts?

thanks,

greg k-h
