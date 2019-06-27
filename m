Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC947C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D09B20843
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 06:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ur+/R8g8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfF0Gix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 02:38:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56740 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfF0Giw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 02:38:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R6XYRU021300;
        Thu, 27 Jun 2019 06:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=YjE7SJlOZfPWmKNq+pc874QvmZFRvtKwDqs9768+UBw=;
 b=Ur+/R8g8sLOoHPLlPb5tKBzZ3Wn/y6j1O5ba8ytsuug07ZYHmbUHMO0+sttZpVHmuClM
 2gvndOqExUQk2BIn+4Z+A7GDLMvsu8CgcX4oxXVSwxyFIvoz3FFWh7IYkMbJr9iLlxVV
 R715OAl4e80r7O8ukIhK+FKrCKvUBcXGC3omhgd6Q6K/c286F+6OP8FOBSbl9YJP2I9s
 m9s92zRZ0fNVmcf7Go8gUmjokYP5zP+T3yg9F7GXt/Y4PuK9rT8NZ7OOscKWX5XSj+yK
 N1C5+NqnFhcNfunx91hQOxjH8Lp87JgZeBjf8kWh7qDMv7fLMUqD/pbX1hDJD19mrxkx UQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brtec1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 06:38:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R6bu9v030198;
        Thu, 27 Jun 2019 06:38:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t9acd2t5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 06:38:43 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5R6cfRl009357;
        Thu, 27 Jun 2019 06:38:42 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 23:38:41 -0700
Date:   Thu, 27 Jun 2019 09:38:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: hal: sdio_halinit: Remove set but
 unused varilable pHalData
Message-ID: <20190627063835.GH28859@kadam>
References: <20190626174459.GA8539@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626174459.GA8539@hari-Inspiron-1545>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=959
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 11:14:59PM +0530, Hariprasad Kelam wrote:
> @@ -1433,7 +1430,6 @@ static void SetHwReg8723BS(struct adapter *padapter, u8 variable, u8 *val)
>  #endif
>  #endif
>  
> -	pHalData = GET_HAL_DATA(padapter);
>  
>  	switch (variable) {

We need to delete one of those blank lines or it introduces a new
checkpatch warning.

regards,
dan carpenter

