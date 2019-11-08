Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4B4FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2B821D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 09:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfKHJgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 04:36:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730573AbfKHJgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 04:36:03 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA89ZUvv023781
        for <linux-kernel@vger.kernel.org>; Fri, 8 Nov 2019 04:36:02 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w55nn8d6g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 04:36:01 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alistair@popple.id.au>;
        Fri, 8 Nov 2019 09:35:59 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 8 Nov 2019 09:35:56 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA89ZtZm24510474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 09:35:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD9AA4C04E;
        Fri,  8 Nov 2019 09:35:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DAD34C046;
        Fri,  8 Nov 2019 09:35:54 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 09:35:54 +0000 (GMT)
Received: from townsend.localnet (unknown [9.81.221.11])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B17F9A0273;
        Fri,  8 Nov 2019 20:35:51 +1100 (AEDT)
From:   Alistair Popple <alistair@popple.id.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org
Subject: Re: [PATCH v2 03/11] ABI: Update FSI path documentation
Date:   Fri, 08 Nov 2019 20:27:47 +1100
In-Reply-To: <20191108051945.7109-4-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au> <20191108051945.7109-4-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-TM-AS-GCONF: 00
x-cbid: 19110809-0028-0000-0000-000003B416AA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110809-0029-0000-0000-00002477177B
Message-Id: <3563232.FuPAt9pb84@townsend>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 8 November 2019 4:19:37 PM AEDT Joel Stanley wrote:
> The paths added back in 4.13 weren't quite correct. The in reality the

Minor nit-pick, it should read "In reality the...". Otherwise looks reasonable.

Acked-by: Alistair Popple <alistair@popple.id.au>

> files documented lived under
> 
>   /sys/devices/../fsi0/rescan
>   /sys/devices/../fsi0/break
>   /sys/devices/../fsi0/slave@00:00/term
>   /sys/devices/../fsi0/slave@00:00/raw
> 
> In 5.5 with the addition of the FSI class they move to
> 
>   /sys/devices/../fsi-master/fsi0/rescan
>   /sys/devices/../fsi-master/fsi0/break
>   /sys/devices/../fsi-master/fsi0/slave@00:00/term
>   /sys/devices/../fsi-master/fsi0/slave@00:00/raw
> 
> This is closer to how the (incorrect) documentation described them.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/ABI/testing/sysfs-bus-fsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-fsi b/Documentation/ABI/testing/sysfs-bus-fsi
> index 57c806350d6c..320697bdf41d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-fsi
> +++ b/Documentation/ABI/testing/sysfs-bus-fsi
> @@ -1,25 +1,25 @@
> -What:           /sys/bus/platform/devices/fsi-master/rescan
> +What:           /sys/bus/platform/devices/../fsi-master/fsi0/rescan
>  Date:		May 2017
>  KernelVersion:  4.12
> -Contact:        cbostic@linux.vnet.ibm.com
> +Contact:        linux-fsi@lists.ozlabs.org
>  Description:
>                  Initiates a FSI master scan for all connected slave devices
>  		on its links.
>  
> -What:           /sys/bus/platform/devices/fsi-master/break
> +What:           /sys/bus/platform/devices/../fsi-master/fsi0/break
>  Date:		May 2017
>  KernelVersion:  4.12
> -Contact:        cbostic@linux.vnet.ibm.com
> +Contact:        linux-fsi@lists.ozlabs.org
>  Description:
>  		Sends an FSI BREAK command on a master's communication
>  		link to any connnected slaves.  A BREAK resets connected
>  		device's logic and preps it to receive further commands
>  		from the master.
>  
> -What:           /sys/bus/platform/devices/fsi-master/slave@00:00/term
> +What:           /sys/bus/platform/devices/../fsi-master/fsi0/slave@00:00/term
>  Date:		May 2017
>  KernelVersion:  4.12
> -Contact:        cbostic@linux.vnet.ibm.com
> +Contact:        linux-fsi@lists.ozlabs.org
>  Description:
>  		Sends an FSI terminate command from the master to its
>  		connected slave. A terminate resets the slave's state machines
> @@ -29,10 +29,10 @@ Description:
>  		ongoing operation in case of an expired 'Master Time Out'
>  		timer.
>  
> -What:           /sys/bus/platform/devices/fsi-master/slave@00:00/raw
> +What:           /sys/bus/platform/devices/../fsi-master/fsi0/slave@00:00/raw
>  Date:		May 2017
>  KernelVersion:  4.12
> -Contact:        cbostic@linux.vnet.ibm.com
> +Contact:        linux-fsi@lists.ozlabs.org
>  Description:
>  		Provides a means of reading/writing a 32 bit value from/to a
>  		specified FSI bus address.
> 




