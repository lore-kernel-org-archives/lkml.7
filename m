Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94662C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61401205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C7qFtYY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbfDDJbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:31:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60572 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732782AbfDDJJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:09:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3499C0P117841;
        Thu, 4 Apr 2019 09:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=JDv010dhrPLwC3J9tGRK6LOYCBaVzJNmY5i8WbNcgdQ=;
 b=C7qFtYY6NqlsORS5QT0Dt7MxbLbujKXHyAnD7RvXys2129o2alTpAet6FClcGGE5N1EJ
 N1hQTWRAroqn5M0wsuVcj9/LhPC+6wTu8d8I3WeRQD9WXpRKwzhAUkcMn03VUCFATYJm
 CXpRzVEycfKgbyvSjspeZYJYO2Tg0EBUDOalQd8Gh92Pu1KdrDw4xlciOzwgAhNoAtPq
 bkSfhQd1d5q4y7JzRrWhQyYYHzOMV8v4yKHrhgpjZDTJKZ6bKrP5Dcw7VKAfAbdGBpBC
 39PRXg+Qp+muUXa5OWNGCeWLyyPxm4Wm15dnATLczf9+Ys4xGaMikzXXn7UVTo+gYi/T sQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2rj13qdsu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 09:09:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3498I7d147321;
        Thu, 4 Apr 2019 09:09:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2rm8f5hxsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Apr 2019 09:09:11 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x34999dE015665;
        Thu, 4 Apr 2019 09:09:11 GMT
Received: from kadam (/41.202.241.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Apr 2019 02:09:09 -0700
Date:   Thu, 4 Apr 2019 12:09:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: rtlwifi: Remove unwanted parentheses
Message-ID: <20190404090900.GH32590@kadam>
References: <20190403223851.22524-1-madhumithabiw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403223851.22524-1-madhumithabiw@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904040065
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9216 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904040065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You should probably update the subject line because now it's not just
about parentheses any more.

[PATCH v2] Staging: rtlwifi: clean up crc16_ccitt()

So the one thing per patch rule is a little bit about selling your
patch.  We never allow "Clean up whole_file.c" but we do sometimes allow
"Clean up a function()" so long as the patch description sells it in
the right way.

Blah blah function does "BIT(0) << i" instead of "BIT(i)".  Using !!
is slightly shorter than "foo ? 1 : 0".  Blah blah, etc.

On Wed, Apr 03, 2019 at 05:38:51PM -0500, Madhumitha Prabakaran wrote:
> @@ -351,13 +351,13 @@ static u16 crc16_ccitt(u8 data, u16 crc)
>  		else
>  			result |= BIT(0);
>  
> -		crc_bit11 = ((crc & BIT(11)) ? 1 : 0) ^ shift_in;
> +		crc_bit11 = !!(crc & BIT(11)) ^ shift_in;
>  		if (crc_bit11 == 0)
>  			result &= (~BIT(12));
                                  ^        ^
I thought your Coccinelle script was going to complain about these
parentheses.  Probably the &= confuses it?  There are a couple others
in the same function.

regards,
dan carpenter
