Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB30CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8083920717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UNsO2OmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbfJ1IkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:40:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51240 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbfJ1IkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:40:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9S8ShU8008098;
        Mon, 28 Oct 2019 08:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=AAreTZABI2sh5zxTgDMdtRwIgOOV26iDp41KT28HdQ0=;
 b=UNsO2OmZ6Ov72DOxYYNKxnT5P4or0VeIn9lktNKJymAjn73V43N6R9p/X7p/hIke7nUf
 eHp5Suj32ekGYYTf8IL3JTCWYpTc7Lv7nsRwE3fEHO+ZniEUuBi0eemVEk7vjFUR9OGa
 n3PJq8NXCmYbkTM/WLfnmpIo5LwreP8aij3wKnqeRhjc73z4adcUf7Q2AgjuNcatU6Vd
 G2HROdVQ3rynTQHtYi2RtZX7sRZ4h66Z/MeWIkmiEgiep+P9rYj0ERTT+/ED4Iids7Uo
 P/a8guaDSjf+8/tKqtxZrrzf67e3EuhDz30oih7tIkx99FxLsVfmhFtCIraColSugwVj UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vvumf57vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 08:40:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9S8SAHp122316;
        Mon, 28 Oct 2019 08:40:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vwakxm0y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 08:40:15 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9S8eE0s024446;
        Mon, 28 Oct 2019 08:40:14 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Oct 2019 01:40:13 -0700
Date:   Mon, 28 Oct 2019 11:40:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Cristiane Naves <cristianenavescardoso09@gmail.com>,
        outreachy-kernel@googlegroups.com, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Remove unneeded variable
Message-ID: <20191028084007.GC1922@kadam>
References: <20191026222453.GA14562@cristiane-Inspiron-5420>
 <20191028082732.GE1944@kadam>
 <alpine.DEB.2.21.1910280934430.2348@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910280934430.2348@hadrien>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910280086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9423 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910280086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 09:36:04AM +0100, Julia Lawall wrote:
> 
> 
> On Mon, 28 Oct 2019, Dan Carpenter wrote:
> 
> > On Sat, Oct 26, 2019 at 07:24:53PM -0300, Cristiane Naves wrote:
> > > Remove unneeded variable used to store return value. Issue found by
> > > coccicheck.
> > >
> > > Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
> > > ---
> > >  drivers/staging/octeon/octeon-stubs.h | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> > > index b07f5e2..d53bd801 100644
> > > --- a/drivers/staging/octeon/octeon-stubs.h
> > > +++ b/drivers/staging/octeon/octeon-stubs.h
> > > @@ -1387,9 +1387,7 @@ static inline cvmx_pko_status_t cvmx_pko_send_packet_finish(uint64_t port,
> > >  		uint64_t queue, union cvmx_pko_command_word0 pko_command,
> > >  		union cvmx_buf_ptr packet, cvmx_pko_lock_t use_locking)
> > >  {
> > > -	cvmx_pko_status_t ret = 0;
> > > -
> > > -	return ret;
> > > +	return 0;
> >
> > What is the point of this function anyway?
> 
> Given that it is in octeon-stubs.h, it seems that the point is to get the
> code to compile when COMPILE_TEST is set.  There is a real definition in
> arch/mips/include/asm/octeon/cvmx-pko.h

Oh yeah...  Duh.  I saw that it was in stubs but I just assumed that it
was stubs for something which was never implemented or left over code...

My bad.

regards,
dan carpente

